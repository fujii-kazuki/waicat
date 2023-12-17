##################################################################

# 管理者

##################################################################

# 環境変数が定義されていない場合、サンプルのメールアドレスとパスワードを設定
email = ENV.has_key?('WAICAT_ADMIN_EMAIL') ? ENV['WAICAT_ADMIN_EMAIL'] : 'admin@example.com'
password = ENV.has_key?('WAICAT_ADMIN_PASSWORD') ? ENV['WAICAT_ADMIN_PASSWORD'] : 'password'

Admin.find_or_create_by!(email: email) do |admin|
  puts 'Adminモデルのレコード作成'
  
  admin.password = password
end