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
            if params[:name] == ""
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

    get '/recipients/:id' do
        if Helpers.is_logged_in?(session)  
            @recipient = Recipient.find_by_id(params[:id])
            erb :'/recipients/show_recipient'
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

    patch '/recipients/:id' do
        if Helpers.is_logged_in?(session)
          if params[:name] == ""
            redirect to "/recipients/#{params[:id]}/edit"
          else
            @recipient = Recipient.find_by_id(params[:id])
            if @recipient && @recipient.user == Helpers.current_user(session)
              if @recipient.update(
                  name: params[:name], 
                  relationship: params[:relationship],
                  birth_month: params[:birth_month],
                  birth_day: params[:birth_day]
                  )
                redirect to "/recipients/#{@recipient.id}"
              else
                redirect to "/recipients/#{@recipient.id}/edit"
              end
            else
              redirect to '/recipients'
            end
          end
        else
          redirect to '/login'
        end
      end

    delete '/recipients/:id/delete' do 
        if Helpers.is_logged_in?(session)
            @recipient = Recipient.find_by_id(params[:id])
            if @recipient && @recipient.user == Helpers.current_user(session)
                @recipient.delete
            end  
            redirect to '/recipients'
        else 
            redirect to '/login'
        end 
    end   

end