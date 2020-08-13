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

    post "/signup" do
        user = User.new(:username => params[:username], :password => params[:password])
       
        if user.save
          redirect "/login"
        else
          redirect "/failure"
        end
      end

end