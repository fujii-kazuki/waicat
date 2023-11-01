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

# 会員
15.times do |num|
  User.create!(
    name: "猫山太郎-#{num}",
    email: "sample@sample#{num}.jp",
    telephone_number: '00000000000',
    postal_code: '0000000',
    address: "大阪府大阪市中央区難波◯丁目1-#{num}",
    password: '000000'
  )
end