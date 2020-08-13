class RecipientsController < ApplicationController

    get '/recipients' do
        if logged_in? 
            @recipients = Recipient.all
            erb :'recipients/recipients'
        else
            redirect to '/login'   
        end 
    end

end