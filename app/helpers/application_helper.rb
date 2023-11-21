module ApplicationHelper
  # adminページ判定
  def admin_url?
    request.fullpath.include?("/admin")
  end

  # 引数のUserモデルがログイン会員と同じIDか判定
  def current_user?(user)
    user_signed_in? && current_user.id == user.id
  end

  # テキストエリアで入力した改行、段落を保持したまま表示
  def show_text(text)
    safe_join(text.split("\n"),tag(:br))
  end
end
