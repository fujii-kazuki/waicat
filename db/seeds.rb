# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 管理者
Admin.create!(
  email: 'admin@admin',
  password: 'adminmin'
)

# ゲストユーザー
User.create!(
  name: 'ゲストユーザー',
  email: 'guest@example.com',
  postal_code: '1234567',
  address: '**********',
  telephone_number: '09012345678',
  password: SecureRandom.urlsafe_base64
)

# 会員
15.times do |num|
  num += 1
  User.create!(
    name: "猫山太郎-#{num}",
    email: "sample@sample#{num}.jp",
    telephone_number: '00000000000',
    postal_code: '0000000',
    address: "大阪府大阪市中央区難波◯丁目1-#{num}",
    password: '000000'
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
15.times do |num|
  num += 1
  publication_date = Time.zone.now
  publication_deadline = publication_date.since(rand(2..14).days)

  cat = Cat.new(
    user_id: num,
    publication_title: "タイトル-#{num}",
    name: "#{num}にゃん",
    age: Random.rand(12.5).ceil(1),
    gender: rand(0..1),
    weight: Random.rand(8.5).ceil(1),
    breed: breed_names.sample,
    animal_print: animal_print_names.sample,
    hair_length: rand(0..1),
    castration_flag: [true, false].sample,
    vaccine_flag: [true, false].sample,
    postal_code: '1234567',
    prefecture: '都道府県',
    municipalitie: '市区町村',
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