require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['ENV_SESSION_SECRET']
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect '/home'
    else
    @session = session
    erb :index
    end
  end

  get '/failure' do
    erb :failure
  end
end
