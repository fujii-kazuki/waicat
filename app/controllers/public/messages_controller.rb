class Public::MessagesController < ApplicationController
  def create
    chatroom = Chatroom.find(params[:chatroom_id])
    # 削除フラグ確認
    if chatroom.deleted_flag
      flash.now[:danger] = 'このチャットルームは既に終了しています。'

    else
      @message = current_user.messages.new(message_params)
      @message.chatroom_id = chatroom.id
      # 空メッセージ判定
      if @message.empty_body?
        flash.now[:danger] = '内容を入力してください。'
      else
        @message.save
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
