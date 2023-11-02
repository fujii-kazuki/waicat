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

# 猫ちゃん
time_from = Time.zone.parse('2022-01-01 00:00:00')
time_to = Time.zone.now
15.times do |num|
  num += 1
  publication_date = rand(time_from...time_to)
  publication_deadline = publication_date.since(rand(5..30).days)

  Cat.create!(
    user_id: num,
    publication_title: "タイトル-#{num}",
    name: "#{num}にゃん",
    age: Random.rand(12.5).ceil(1),
    gender: rand(0..1),
    weight: Random.rand(8.5).ceil(1),
    breed: '種類',
    animal_print: '毛の柄',
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
    publication_status: rand(0..5)
  )
end