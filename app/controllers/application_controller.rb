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
    @skip_login_logout_footer = true
    erb :index
    end
  end
end
