class Admin::HomesController < ApplicationController
  def top
    @menus = [
      #表示名, 英語名, アイコン, パス
      ['会員', 'users', '<i class="fa-solid fa-user"></i>', admin_users_path],
      ['掲載', 'cats', '<i class="fa-solid fa-paw"></i>', admin_cats_path],
      ['チャットルーム', 'chatrooms', '<i class="fa-solid fa-comments"></i>', admin_chatrooms_path],
      ['お問い合わせ', 'contacts', '<i class="fa-solid fa-envelope"></i>', admin_contacts_path]
    ]
    # 管理者がまだ確認していないお問い合わせ件数
    @unreaded_contacts_num = Contact.where(readed_flag: false).count
  end
end