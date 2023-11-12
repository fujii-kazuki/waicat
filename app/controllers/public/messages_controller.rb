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
        @messages = Message.where(chatroom_id: chatroom.id, readed_flag: false).where.not(user_id: current_user.id)
        # 相手のメッセージを既読にする
        read_messages(@messages)
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  # 相手のメッセージを既読にする
  def read_messages(messages)
    messages.each do |message|
      message.update(readed_flag: true) if message.user_id != current_user.id
    end
  end
end
