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

# 里親募集掲載
require seeds_path('cat')

# お問い合わせ
require seeds_path('contact')

puts 'seedの実行を完了'