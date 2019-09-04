class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        erb :'tweets/index'
    end

    post '/tweets' do
        binding.pry
        user = session[:user]
        tweet = Tweet.create(content: params[:content], user_id: user.id)
        erb :'tweets/index'
    end

end
