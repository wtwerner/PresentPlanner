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
                @list = List.new(name: params[:name], recipient: Recipient.find_by_name(params[:recipient]), event_date: params[:event_date])
                puts Recipient.find_by_name(params[:recipient])
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

    get '/lists/:id' do
        if Helpers.is_logged_in?(session)  
            @list = List.find_by_id(params[:id])
            erb :'/lists/show_list'
        else 
            redirect to '/login'
        end  
    end 

end