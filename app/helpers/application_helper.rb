module ApplicationHelper
  # URLにadminが含まれているか判定
  def admin_url?
    request.fullpath.include?("/admin")
  end

  # テキストエリアで入力した改行、段落を保持したまま表示
  def show_text(text)
    safe_join(text.split("\n"),tag(:br))
  end
end
