require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      redirect to './tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save && params[:username].length > 0 && params[:email].length > 0
        session[:user_id] = @user.id
        redirect to "/tweets"
    else
        redirect to "/signup"
    end
end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear

    redirect to "/login"
  end


end
