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

  # 会員プロフィール画像のURLを返す
  def profile_image_url(user)
    if user.avatar.attached?
      rails_blob_url(user.profile_image)
    else
      asset_path('avatar-default.png')
    end
  end

  # Gem「ransack」のソートリンクのアイコンを表示
  def sort_link_arrow(column_name)
    if !params[:q].nil? && params[:q][:s] == "#{column_name} asc"
      '<i class="fa-solid fa-caret-up"></i>'.html_safe
    else
      '<i class="fa-solid fa-caret-down"></i>'.html_safe
    end
  end
end
