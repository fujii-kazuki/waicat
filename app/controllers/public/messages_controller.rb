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
        # リアルタイムチャット表示
        ActionCable.server.broadcast 'message_channel', { user: current_user, message: @message }
        # チャット相手に通知を送信
        message_notice(
          sender: @message.user, #送信者
          recipient: chatroom.chat_partner(current_user), #受信者
          message: @message #メッセージ
        )
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  # チャット相手に通知を送信
  def message_notice(sender:, recipient:, message:) #送信者, 受信者, メッセージ
    # 通知を作成
    Notice.create(
      user_id: recipient.id,
      title: "#{sender.name}さんとのチャットルームにメッセージの着信がありました",
      body: "#{message.body}",
      url: chatroom_path(message.chatroom.id)
    )
  end
end
