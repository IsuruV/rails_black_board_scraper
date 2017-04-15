class MessagesController < ApplicationController
    def create
        # require 'pry'; binding.pry
        message = Message.new(content: message_params[:content], classroom_id: message_params[:classroom_id], user_id: current_user.id)
        if message.save
            ActionCable.server.broadcast 'messages',
            message_room_id: message.classroom_id,
            message: message.content,
            user: message.user
            head :ok
        end
    end
    
    def index
        # require 'pry'; binding.pry
        @messages = Message.all.where(classroom_id: message_all_params)
        render json: {"messages": @messages.map{|message| message.message_format}}
        #  respond_to do |format|
        #     format.html
        #     format.json
        # end
    end 
    
private
    def message_params
      params.require(:message).permit(:content, :classroom_id)
    end
    def message_all_params
        params.require(:class_id)
    end
    
end

