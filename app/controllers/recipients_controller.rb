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

    post '/recipients' do
        if Helpers.is_logged_in?(session)
            if params[:content] == ""
                redirect to '/recipients/new'
            else 
                @recipient = Recipient.new(params)
                @recipient.user = Helpers.current_user(session)
                if @recipient.save
                    redirect to "/recipients/#{@recipient.id}"
                else 
                    redirect to '/recipients/new'
                end 
            end 
        else 
            redirect to '/login'
        end 
    end

    get '/recipients/:id/edit' do 
        @recipient = Recipient.find_by_id(params[:id])
        if Helpers.is_logged_in?(session) && Helpers.current_user(session) == @recipient.user
            erb :'/recipients/edit'
        else 
            redirect to '/login'
        end 
    end 

end