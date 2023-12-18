##################################################################

# 毛の柄

##################################################################

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
  AnimalPrint.find_or_create_by!(name: animal_print_name) do |animal_print|
    puts "AnimalPrintモデルのレコード作成"

    animal_print.name = animal_print_name
  end
end