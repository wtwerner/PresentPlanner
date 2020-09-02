class UsersController < ApplicationController
    
    get '/signup' do 
      if !Helpers.is_logged_in?(session)
          erb :'/users/signup'
      else
          redirect to '/home'
      end 
    end

    post '/signup' do
      user = User.new(:email => params[:email], :name => params[:name], :password => params[:password])
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
        redirect '/home'
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

    get '/home' do
      if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        @ordered_recipients = Recipient.order("name ASC")
        @ordered_lists = List.order("event_date ASC")
        erb :'/users/home'
      else
        redirect to '/'
      end
    end
    
end