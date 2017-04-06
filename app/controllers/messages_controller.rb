class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        if message.save
            ActionCable.server.broadcast 'messages',
            message: message.content,
            user: message.user
            head :ok
        end
    end
    
    def index
        # require 'pry'; binding.pry
        @messages = Message.all.where(classroom_id: message_all_params)
        render json: {"messages": @messages.map{|message| message.message_format}}
    end
    
private
    def message_params
      params.require(:message).permit(:content, :chatroom_id, :user_id)
    end
    def message_all_params
        params.require(:class_id)
    end
    
end

