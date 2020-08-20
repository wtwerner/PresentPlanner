class ListsController < ApplicationController
    
    get '/lists' do
        if Helpers.is_logged_in?(session)
            @lists = List.all
            @recipients = Recipient.all
            erb :'lists/lists'
        else
            redirect to '/login'   
        end  
    end

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
                @list = List.new(
                    name: params[:name], 
                    recipient: Recipient.find_by_name(params[:recipient]), 
                    event_date: params[:event_date]
                )
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

    get '/lists/:id/edit' do 
        @list = List.find_by_id(params[:id])
        @recipients = Recipient.all
        if Helpers.is_logged_in?(session)
            erb :'/lists/edit'
        else 
            redirect to '/login'
        end 
    end 

    patch '/lists/:id' do
        if Helpers.is_logged_in?(session)
          if params[:name] == ""
            redirect to "/lists/#{params[:id]}/edit"
          else
            @list = List.find_by_id(params[:id])
            if @list
              if @list.update(
                    name: params[:name], 
                    recipient: Recipient.find_by_name(params[:recipient]), 
                    event_date: params[:event_date]
                    )
                redirect to "/lists/#{@list.id}"
              else
                redirect to "/lists/#{@list.id}/edit"
              end
            else
              redirect to '/lists'
            end
          end
        else
          redirect to '/login'
        end
      end

    delete '/lists/:id/delete' do 
        if Helpers.is_logged_in?(session)
            @list = List.find_by_id(params[:id])
            if @list && @list.recipient.user == Helpers.current_user(session)
                @list.delete
            end  
            redirect to '/lists'
        else 
            redirect to '/login'
        end 
    end   

end