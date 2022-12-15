require 'sinatra/base'

class ChitterApp < Sinatra::Base

  set :bind, '0.0.0.0'
  set :port, 8080

  get '/' do
    'Hello Moto'
  end

  run! if app_file == $0
end

