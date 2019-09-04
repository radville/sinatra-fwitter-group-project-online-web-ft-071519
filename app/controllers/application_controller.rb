require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id].nil?
      erb :'users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    if @user.save && params[:username].length > 0 && params[:email].length > 0
        session[:user_id] = @user.id
        redirect to "/tweets"
    else
        redirect to "/signup"
    end
    binding.pry

end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username], :password => params[:password], :email => params[:email])
    session[:user_id] = @user.id
  end

  get '/logout' do
    session.clear
  end


end
