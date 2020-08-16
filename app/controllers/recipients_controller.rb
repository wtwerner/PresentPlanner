class RecipientsController < ApplicationController

    get '/recipients' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'recipients/recipients'
        else
            redirect to '/login'   
        end 
    end

    get '/recipients/new' do
        if Helpers.is_logged_in?(session)
            erb :'recipients/new'
        else
            redirect to '/login'   
        end 
    end

end