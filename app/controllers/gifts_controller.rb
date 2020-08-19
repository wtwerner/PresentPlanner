class GiftsController < ApplicationController

    get '/gifts' do
        if Helpers.is_logged_in?(session)
            @gifts = Gift.all
            erb :'gifts/gifts'
        else
            redirect to '/login'   
        end   
    end

    get '/gifts/new' do
        if Helpers.is_logged_in?(session)
            @recipients = Recipient.all
            erb :'gifts/new'
        else
            redirect to '/login'   
        end 
    end

    post '/gifts' do
        if Helpers.is_logged_in?(session)
            if params[:name] == ""
                redirect to '/gifts/new'
            else 
                @gift = Gift.new(
                    name: params[:name], 
                    price: params[:price], 
                    url: params[:url],
                    description: params[:description],
                    note: params[:note],
                    recipient_id: Recipient.find_by_name(params[:recipient]).id
                )
                if @gift.save
                    redirect to "/gifts/#{@gift.id}"
                else 
                    redirect to '/gifts/new'
                end 
            end 
        else 
            redirect to '/login'
        end 
    end

    get '/gifts/:id' do
        if Helpers.is_logged_in?(session)  
            @gift = Gift.find_by_id(params[:id])
            erb :'/gifts/show_gift'
        else 
            redirect to '/login'
        end  
    end 

    get '/gifts/:id/edit' do 
        @gift = Gift.find_by_id(params[:id])
        @recipients = Recipient.all
        if Helpers.is_logged_in?(session) && Helpers.current_user(session) == @gift.recipient.user
            erb :'/gifts/edit'
        else 
            redirect to '/login'
        end 
    end 

    patch '/gifts/:id' do
        if Helpers.is_logged_in?(session)
            if params[:name] == ""
                redirect to "/gifts/#{params[:id]}/edit"
            else
                @gift = Gift.find_by_id(params[:id])
                if @gift && @gift.recipient.user == Helpers.current_user(session)
                if @gift.update(
                    name: params[:name], 
                    price: params[:price], 
                    url: params[:url],
                    description: params[:description],
                    note: params[:note],
                    recipient_id: Recipient.find_by_name(params[:recipient]).id
                    )
                redirect to "/gifts/#{@gift.id}"
            else
                redirect to "/gifts/#{@gift.id}/edit"
            end
            else
                redirect to '/gifts'
            end
        end
        else
            redirect to '/login'
        end
    end

    delete '/gifts/:id/delete' do 
        if Helpers.is_logged_in?(session)
            @gift = Gift.find_by_id(params[:id])
            if @gift && @gift.recipient.user == Helpers.current_user(session)
                @gift.delete
            end  
            redirect to '/gifts'
        else 
            redirect to '/login'
        end 
    end   

end