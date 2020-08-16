require './config/environment'

class ApplicationController < Sinatra::Base

  SESSION_SECRET = ENV['env_session_secret']

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, SESSION_SECRET
  end

  get '/' do
    @session = session
    erb :index
  end
end
