# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'seedの実行を開始'

# seedsフォルダ内の引数ファイルのパスを返す
def seeds_path(file_name)
  return "./db/seeds/#{file_name}.rb"
end

# 管理者
require seeds_path('admin')

# ゲストユーザー
require seeds_path('guest_user')

# 都道府県
require seeds_path('prefecture')

# 会員
require seeds_path('user')

# 種類
require seeds_path('breed')

# 毛の柄
require seeds_path('animal_print')


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

puts 'seedの実行を完了'