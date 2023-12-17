# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# レコード作成完了メッセージ
def records_created_complete_message(records_name)
  puts "#{records_name}のレコードが作成されました"
end

puts 'seedの実行を開始'

##################################################################

# 管理者

##################################################################

def admin_seed
  # 環境変数が定義されていない場合、サンプルのメールアドレスとパスワードを設定
  email = ENV.has_key?('WAICAT_ADMIN_EMAIL') ? ENV['WAICAT_ADMIN_EMAIL'] : 'admin@example.com'
  password = ENV.has_key?('WAICAT_ADMIN_PASSWORD') ? ENV['WAICAT_ADMIN_PASSWORD'] : 'password'

  Admin.find_or_create_by!(email: email) do |admin|
    admin.password = password
    # レコード作成完了メッセージ
    records_created_complete_message('管理者')
  end
end

admin_seed()


##################################################################

# ゲストユーザー

##################################################################

def guest_user_seed
  email = User.get_guest_user_email # 環境変数が定義されていない場合、サンプルのメールアドレスを設定
  password = SecureRandom.urlsafe_base64

  User.find_or_create_by!(email: email) do |guest_user|
    guest_user.name = 'ゲストユーザー'
    guest_user.postal_code = '0000000'
    guest_user.prefecture = '***'
    guest_user.city = '***'
    guest_user.telephone_number = '00000000000'
    guest_user.password = password
    # レコード作成完了メッセージ
    records_created_complete_message('ゲストユーザー')
  end
end

guest_user_seed()


##################################################################

# 都道府県

##################################################################

def prefectures_seed
  prefecture_names = [
    '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
    '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
    '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
    '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
    '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
    '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
    '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県'
  ]
  
  prefecture_names.each do |prefecture_name|
    Prefecture.find_or_create_by!(name: prefecture_name) do |prefecture|
      prefecture.name = prefecture_name
    end
  end
end

prefectures_seed()


# 会員
15.times do |i|
  i += 1
  User.create!(
    name: "猫山太郎-#{i}",
    telephone_number: '09012345678',
    email: "test@test#{i}",
    postal_code: '1234567',
    prefecture: Prefecture.find(rand(1..47)).name,
    city: "にゃん#{i}区",
    password: 'password'
  )
end

# 種類
breed_names = [
  '雑種（ミックス）',
  'スコティッシュフォールド',
  'マンチカン',
  'アメリカンショートヘア',
  'ラグドール',
  'ブリティッシュショートヘア',
  'ノルウェージャンフォレストキャット',
  'サイベリアン',
  'ロシアンブルー',
  'ベンガル',
  'アメリカンカール',
  'メインクーン',
  'ペルシャ',
  'ラガマフィン',
  'エキゾチック',
  'シャム猫(サイアミーズ）',
  'ソマリ',
  'アビシニアン',
  'シンガプーラ',
  'トンキニーズ',
  'シャルトリュー',
  'ヒマラヤン',
  'セルカークレックス',
  'ボンベイ',
  'マンチカール',
  'エジプシャンマウ',
  'ジャパニーズ・ボブテイル',
  'オシキャット',
  'ラパーマ',
  'バーマン',
  'その他'
]
breed_names.each do |breed_name|
  Breed.create!(name: breed_name)
end

# 毛の柄
animal_print_names = [
  '白（ホワイト）',
  '黒（ブラック）',
  '灰色（グレー）',
  'キジトラ（ブラウンタビー）',
  'サバトラ（シルバータビー）',
  '茶トラ（レッドタビー）',
  '黒白／白黒（ブラック＆ホワイト／ホワイト＆ブラック）',
  '三毛（キャリコ）',
  'サビ（トーティシェル）',
  'キジ白（ブラウンタビー&ホワイト）',
  'サバ白（シルバータビー&ホワイト）',
  '茶白（レッドタビー&ホワイト）',
  'その他'
]
animal_print_names.each do |animal_print_name|
  AnimalPrint.create!(name: animal_print_name)
end

# 猫ちゃん
15.times do |i|
  i += 1
  publication_date = Time.zone.now
  publication_deadline = publication_date.since(rand(2..14).days)

  cat = Cat.new(
    user_id: i,
    publication_title: "タイトル-#{i}",
    name: "#{i}にゃん",
    age: Random.rand(12.5).ceil(1),
    gender: rand(0..1),
    weight: Random.rand(8.5).ceil(1),
    breed: breed_names.sample,
    animal_print: animal_print_names.sample,
    hair_length: rand(0..1),
    castration_flag: [true, false].sample,
    vaccine_flag: [true, false].sample,
    postal_code: '1234567',
    prefecture: Prefecture.find(rand(1..47)).name,
    city: "にゃん#{i}町",
    background: '里親募集の経緯',
    personality: '性格',
    health: '健康状態',
    delivery_place: '譲渡場所',
    remarks: '備考',
    publication_date: publication_date,
    publication_deadline: publication_deadline,
    publication_status: rand(0..6)
  )
  # 画像を登録
  cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-1.jpg")), filename: "img-1.jpg")
  cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-2.jpg")), filename: "img-2.jpg")
  cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-3.jpg")), filename: "img-3.jpg")
  cat.save!
end

# コメント
2.times do |i|
  i += 1

  5.times do |j|
    j += 1

    Comment.create!(
      cat_id: i,
      user_id: j,
      body: "#{User.find(j).name}のテストコメント"
    )
  end
end

# 通知
15.times do |i|
  i += 1
  Notice.create!(
    user_id: rand(1..2),
    title: "通知-#{i}",
    body: "通知内容です-#{i}。通知内容です-#{i}。通知内容です-#{i}。通知内容です-#{i}。通知内容です-#{i}。
          通知内容です-#{i}。通知内容です-#{i}。通知内容です-#{i}。",
  )
end

# お問い合わせ
15.times do |i|
  i += 1
  Contact.create!(
    user_id: i,
    title: "お問い合わせタイトル-#{i}",
    body: "#{i}-お問い合わせ内容ですお問い合わせ内容ですお問い合わせ内容ですお問い合わせ内容ですお問い合わせ内容です"
  )
end

puts 'seedの実行が完了しました'