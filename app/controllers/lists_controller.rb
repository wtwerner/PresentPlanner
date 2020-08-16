class ListsController < ApplicationController
    
    get '/lists/new' do
        if Helpers.is_logged_in?(session)
            @recipients = Recipient.all
            erb :'lists/new'
        else
            redirect to '/login'   
        end 
    end

    post '/lists' do
        if Helpers.is_logged_in?(session)
            if params[:name] == ""
                redirect to '/lists/new'
            else 
                @list = List.new(params)
                if @list.save
                    redirect to "/lists/#{@list.id}"
                else 
                    redirect to '/lists/new'
                end 
            end 
        else 
            redirect to '/login'
        end 
    end

end