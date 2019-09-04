class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        @user = User.find_by_id(session[:user_id])
        if @user
            erb :'tweets/index'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        if Helpers.is_logged_in?(session) && params[:content].length > 0
            tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            redirect to "/tweets/#{tweet.id}"
        else
            redirect to "/tweets/new"
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'tweets/new'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.is_logged_in?(session)
            erb :'tweets/show'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        @session = session
        puts params
        if Helpers.is_logged_in?(session) && @session[:user_id] == @tweet.user_id
            erb :'tweets/edit'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do 
        tweet = Tweet.find_by_id(params[:id])
        if params[:content].length > 0
            tweet.update(content: params[:content])
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
        redirect to "/tweets/#{tweet.id}"
    end

    delete '/tweets/:id/delete' do
        tweet = Tweet.find_by_id(params[:id])
        if Helpers.is_logged_in?(session) && tweet.user_id == session[:user_id]
            tweet.delete
            redirect to '/tweets'
        end
    end

end
