class Public::ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?
  before_action :check_correct_user, only: [:show, :close]

  def index
    @user = current_user
    @chatrooms = @user.chatroom_users.map { |chatroom_user| chatroom_user.chatroom }
    @chatrooms.sort! { |cr_a, cr_b| cr_b.messages.first.created_at <=> cr_a.messages.first.created_at }
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.reverse
    @message = Message.new
    @candidate = @chatroom.candidate
    @cat = @candidate.cat
  end

  def close
    chatroom = Chatroom.find(params[:id])
    cat = Cat.find(params[:cat_id])
    candidate = chatroom.candidate

    # チャットルームを閉じれる状態か確認
    if candidate.status == 'transfer_completed' &&
       cat.publication_status =='recruitment_closed'

      # メッセージを送信
      Message.create_and_send(
        user_id: current_user.id,
        chatroom_id: chatroom.id,
        body: "※こちらは自動送信メッセージです

              チャットルームはここで終了されました。"
      )
      chatroom.update(deleted_flag: true) #論理削除
      # チャットルームを閉じた事を相手に通知
      close_notice(candidate)
      # チャットルーム一覧ページへリダイレクト
      redirect_to chatrooms_path
    else
      flash[:alert] = '十分に話し合いを進めなければ、このチャットを閉じることはできません。'
      redirect_to chatroom_path(chatroom.id)
    end
  end

  private

  # チャットルームを閉じた事を相手に通知
  def close_notice(candidate)
    candidater = candidate.user #里親立候補者
    cat = candidate.cat #里親募集の猫掲載
    recruiter = cat.user #里親募集者

    # 通知を作成
    Notice.create(
      user_id: candidater.id,
      title: "#{recruiter.name}さんが、あなたとのチャットを終了しました。",
      body: "#{cat.name}の元飼い主の#{recruiter.name}さんが、里親となったあなたに安心し、チャットを終了しました。
            これからも#{cat.name}の里親としてに十分に愛情を注ぎ、可愛がってあげてください♪"
    )
  end

  def check_correct_user
    chatroom = Chatroom.find(params[:id])
    chatroom_user = chatroom.chatroom_users.select { |chatroom_user| chatroom_user.user_id == current_user.id }
    if chatroom.deleted_flag || chatroom_user.empty?
      flash[:alert] = '申し訳ございませんが、その操作を行うことはできません。'
      redirect_to chatrooms_path
    end
  end
end