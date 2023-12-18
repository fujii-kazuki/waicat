class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom-#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
