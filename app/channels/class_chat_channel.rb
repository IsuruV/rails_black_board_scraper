class ClassChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  # def speak(data) 
  #   ActionCable.server.broadcast "messages", message: data['message'] 
  # end
  
  def speak(data)
    # require 'pry'; binding.pry
    message = Message.new(content: data['content'], classroom_id: data['classroom_id'], user_id: data['user_id'])
      if message.save
          ActionCable.server.broadcast 'messages',
          message: message.content,
          user: message.user
          head :ok
      end
  end
  
  private
    def message_params
      params.require(:message).permit(:content, :chatroom_id, :user_id)
    end

end
