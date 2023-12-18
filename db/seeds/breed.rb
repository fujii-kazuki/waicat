##################################################################

# 種類

##################################################################

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
  Breed.find_or_create_by!(name: breed_name) do |breed|
    puts "Breedモデルのレコード作成"

    breed.name = breed_name
  end
end