class UsersController < ApplicationController
    
    get '/signup' do 
        if !logged_in?
            erb :'/users/signup'
        else
            redirect to '/recipients'
        end 
    end


end