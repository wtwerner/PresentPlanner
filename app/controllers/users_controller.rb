class UsersController < ApplicationController
    
    get '/signup' do 
        if !Helpers.is_logged_in?(session)
            erb :'/users/signup'
        else
            puts session
            puts Helpers.is_logged_in?(session)
            puts session[:user_id]
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

      get 'login' do
        erb :'/users/login'
      end


end