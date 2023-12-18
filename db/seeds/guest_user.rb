##################################################################

# ゲストユーザー

##################################################################

email = User.get_guest_user_email # 環境変数が定義されていない場合、サンプルのメールアドレスを設定
password = SecureRandom.urlsafe_base64

User.find_or_create_by!(email: email) do |guest_user|
  puts 'ゲストユーザーのレコード作成'

  guest_user.name = 'ゲストユーザー'
  guest_user.postal_code = '0000000'
  guest_user.prefecture = '***'
  guest_user.city = '***'
  guest_user.telephone_number = '00000000000'
  guest_user.password = password
end