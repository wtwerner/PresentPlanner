require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['env_session_secret']
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect '/recipients'
    else
    @session = session
    erb :index
    end
  end

  get '/failure' do
    erb :failure
  end
end
