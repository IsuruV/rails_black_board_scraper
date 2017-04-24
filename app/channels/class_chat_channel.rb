class ClassChatChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'messages'
  end
  
  # def subscribed
  #   stream_from "room-#{params['classroom_id']}"
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  # def speak(data) 
  #   ActionCable.server.broadcast "messages", message: data['message'] 
  # end
  
  def speak(data)
    message = Message.new(content: data['content'], classroom_id: data['classroom_id'], user_id: data['user_id'])
      if message.save
          ActionCable.server.broadcast 'messages',
          message_room_id: message.classroom_id,
          message: {"content":message.content, "user_id": message.user_id},
          user: message.user
          head :ok
      end
  end
  
end
