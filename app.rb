require 'sinatra/base'
require 'puma'
require 'sinatra/flash'
require_relative './lib/peep'
require_relative './lib/user'
require_relative './lib/database_connection_setup'

class ChitterApp < Sinatra::Base

  register Sinatra::Flash
  enable :sessions

  set :bind, '0.0.0.0'
  set :port, 8080

  get '/' do
    redirect '/peeps'
  end

  get '/peeps/new' do
    if session[:user_id]
      erb :"peeps/new"
    else
      redirect '/peeps'
    end
  end

  post '/peeps' do
    Peep.create(content: params[:content], user_id: session[:user_id])
    redirect '/peeps'
  end

  get '/peeps' do
    @peeps = Peep.all
    @user = User.find(id: session[:user_id])
    erb :'peeps/index'
  end

  get '/users/sign_up' do
    erb:"users/sign_up"
  end

  post '/users/sign_up' do
    user = User.create(
      username: params[:username], email: params[:email], password: params[:password]
    )
    session[:user_id] = user.id
    flash[:notice] = "Welcome, #{user.username}!"

    redirect '/peeps'
  end

  get '/users/log_in' do
    erb :"users/log_in"
  end

  post '/users/log_in' do
    user = User.authenticate(
      email: params[:email],
      password: params[:password]
    )
    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}!"
      redirect '/peeps'
    else
      flash[:notice] = "Incorrect email or password"
      redirect ('/users/log_in')
    end
  end

  get '/users/log_out' do
    session.clear
    redirect '/peeps'
  end

  run! if app_file == $0
end

