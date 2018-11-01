class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	unless data['message'] == ''
      message = Message.new(message: data['message'], room_id: params['room_id'], user_id: params['user_id'])
      message.save
      ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: data['message'], message_id: message.id, user_id: message.user_id
    end
  end
end
