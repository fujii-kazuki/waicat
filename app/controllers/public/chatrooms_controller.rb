class Public::ChatroomsController < ApplicationController
  def index
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @candidate = @chatroom.candidate
    @cat = @candidate.cat
  end
end
