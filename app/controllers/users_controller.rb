class UsersController < ApplicationController
    
    get '/signup' do 
      if !Helpers.is_logged_in?(session)
          erb :'/users/signup'
      else
          redirect to '/recipients'
      end 
    end

    post '/signup' do
      user = User.new(:email => params[:email], :password => params[:password])
      if user.save
        redirect '/login'
      else
        redirect '/failure'
      end
    end

    get '/login' do
      erb :'/users/login'
    end

    post '/login' do
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/recipients'
      else
        redirect '/failure'
      end
    end

    get '/logout' do 
      if Helpers.is_logged_in?(session)
          session.clear
          redirect to '/'
      else
          redirect to '/'
      end 
    end 
    
end