class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        if message.save
            ActionCable.server.broadcast 'messages',
            message: message.content,
            user: message.user.formatted_user_message
            head :ok
        end
    end
    
private
    def message_params
      params.require(:message).permit(:content, :chatroom_id, :user_id)
    end
    
end

