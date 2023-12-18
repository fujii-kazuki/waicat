##################################################################

# 里親募集掲載

##################################################################

# テスト用Catモデルの初期データ
def initial_test_cat(publisher_id)
  # 都道府県
  prefectures = Prefecture.pluck(:name)
  # 市区町村
  city_names = User.pluck(:city)
  # 猫の名前
  cat_names = ['太郎', 'ミケ', 'ヒナタ', 'クロネコ', 'モチモチ', 'サクラ', 'ぽんず', '花子', 'シロネコ', 'ゴロー']
  # 猫の種類
  breed_names = Breed.pluck(:name)
  # 猫の毛柄
  animal_print_names = AnimalPrint.pluck(:name)
  # 里親募集の経緯
  background = '愛らしい我が家の猫が、転勤のため里親を求めます。
                家庭環境変化に伴い、猫との時間が確保できなくなりました。懐っこく、元気な性格で、健康状態も良好です。
                
                里親になってくれる方、ぜひお知らせください。
                ご縁を大切にし、温かい新しい家庭へと繋げていきたいと考えています。'
  # 性格
  personality = '好奇心旺盛で遊び好きなおおらかな性格。
                人懐っこく、いつも一緒にいることが大好き。
                お腹をなでてもらうのが特に好きで、優雅にくつろぐ姿が癒しです。
                新しいおもちゃにはすぐ興味津々で、活発な一面も。
                ただし、ちょっとお腹がすくと、ごはんの用意に興奮し始めます。
                家族みんなとのコミュニケーションを楽しむ、まさににゃんこの魅力全開な存在です。'
  # 健康状態
  health = '猫の健康は絶好調で、定期的な健康診断も問題ありません。
            元気いっぱいで食欲旺盛です。'
  # 譲渡場所
  delivery_place = '飼い猫の譲渡は〇〇県〇〇市〇〇町辺りで行う予定ですが、相談次第です。'
  # 備考
  remarks = 'トイレトレーニングも済んでおり、おとなしい性格です。
            エサは高品質でバランスのとれたものを与え、健康を重視。里親になってくれる方には、猫のお気に入りのベッドやおもちゃをお渡しします。
            
            お家に温かい場所があり、愛情をたっぷり注いでくださる方、どうぞよろしくお願いします。'

  # インスタンス生成
  cat = Cat.new(
    user_id: publisher_id,
    publication_title: '遊び好きな元気な猫ちゃん♪ おとなしく人懐っこい性格。愛情たっぷりの里親を募集中！',
    name: cat_names.sample,
    age: Random.rand(12.5).ceil(1),
    gender: rand(0..1),
    weight: Random.rand(8.5).ceil(1),
    breed: breed_names.sample,
    animal_print: animal_print_names.sample,
    hair_length: rand(0..1),
    castration_flag: [true, false].sample,
    vaccine_flag: [true, false].sample,
    postal_code: '0000000',
    prefecture: prefectures.sample,
    city: city_names.sample,
    background: background,
    personality: personality,
    health: health,
    delivery_place: delivery_place,
    remarks: remarks,
    publication_date: Time.zone.now,
    publication_deadline: Time.zone.now.since(rand(1..13).days),
    publication_status: 1 # 公開
  )
  return cat
end


##### テスト掲載一覧 #####
# 1, 通常
# 2, 写真最高枚数（10枚）
# 3, 動画あり
# 4, 下書き
# 5, 1日間公開（最短公開期間）
# 6, 5日間公開
# 7, 14日間公開（最長公開期間）
# 8, 相談中
# 9, 里親決定
# 10, 募集終了
# 11, 掲載締め切り
# 12, コメント有り
# 13, 削除済み掲載


# 1, 通常
def test_cat_1(publisher_id)
  cat = initial_test_cat(publisher_id)
  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!
end


# 2, 写真最高枚数（10枚）
def test_cat_2(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：写真最高枚数（10枚）'
  
  10.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!
end


# 3, 動画あり
def test_cat_3(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：動画あり'
  5.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.video.attach(io: File.open(Rails.root.join('app/assets/videos/video-1.mp4')), filename: 'video-1.mp4')
  cat.save!
end


# 4, 下書き
def test_cat_4(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：下書き'
  cat.publication_status = 0
  cat.save!
end


# 5, 1日間公開（最短公開期間）
def test_cat_5(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：1日間公開（最短公開期間）'
  cat.publication_deadline = Time.zone.now.since(1.days)
  
  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!
end


# 6, 5日間公開
def test_cat_6(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：5日間公開'
  cat.publication_deadline = Time.zone.now.since(4.days)
  
  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!
end


# 7, 14日間公開（最長公開期間）
def test_cat_7(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：14日間公開'
  cat.publication_deadline = Time.zone.now.since(13.days)
  
  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!
end


# 8, 相談中
def test_cat_8(publisher_id, candidater_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：相談中'

  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!

  publisher = cat.user # 里親募集者
  candidater = User.find(candidater_id) # 里親応募者

  # 掲載ステータスを「相談中」に変更
  cat.update(publication_status: 'in_consultation')
  # 応募モデルのレコード生成
  candidate = candidater.candidates.create!(cat_id: cat.id)
  # チャットルームのレコードを作成
  chatroom = Chatroom.create!(candidate_id: candidate.id)
  # チャットルームユーザーレコードを2つ作成
  # 1つのチャットルームにユーザー2名（里親募集者と応募者）を登録
  chatroom.chatroom_users.create!(user_id: publisher.id)
  chatroom.chatroom_users.create!(user_id: candidater.id)
  # 里親応募メッセージを送信
  Message.create_and_send(
    user_id: candidater.id,
    chatroom_id: chatroom.id,
    body: "※こちらは自動送信メッセージです

          #{cat.name}の里親に応募しました！
          こちらのチャットルームにて、
          
          ・簡単な自己紹介
          ・応募に至った経緯など
          ・猫を迎えるに至っての準備など

          里親決定に向けて話し合いましょう！"
  )
  # 里親募集者に通知を送信
  Notice.create(
    user_id: publisher.id,
    title: "#{candidater.name}さんが#{cat.name}の里親に応募しました",
    body: "#{candidater.name}さんが#{cat.name}の里親に応募されたので、リンク先にて#{candidater.name}さんとのチャットルームが作成されました。
          これから里親決定に向けて、チャットルームで#{candidater.name}さんと話し合いをしましょう。",
    url: Rails.application.routes.url_helpers.chatroom_path(chatroom.id)
  )

  return { cat: cat, candidate: candidate }
end


# 9, 里親決定
def test_cat_9(publisher_id, candidater_id)
  obj = test_cat_8(publisher_id, candidater_id)

  cat = obj[:cat]
  candidate = obj[:candidate]

  cat.publication_title = 'テスト掲載：里親決定'
  # 掲載ステータスを「里親決定」に変更
  cat.update(publication_status: 'foster_parents_decided')
  # 応募ステータスを「里親決定」に変更
  candidate.update(status: 'foster_parents_decided')
  # 里親決定メッセージを自動送信
  Message.create_and_send(
    user_id: cat.user.id,
    chatroom_id: candidate.chatroom.id,
    body: "※こちらは自動送信メッセージです

          #{candidate.user.name}さんを#{cat.name}の里親に決定しました！
          これから#{cat.name}の譲渡に向けて、

          ・譲渡場所
          ・譲渡場所への集合時間
          ・その他連絡事項や必要な物など

          上記の件にて話し合いましょう！

          また、後日無事に#{cat.name}の譲渡が終わりましたら、#{candidate.user.name}さんは「譲渡完了完了ボタン」を押してください。"
  )
  # 応募者に里親決定通知を送信
  Notice.create(
    user_id: candidate.user.id,
    title: "おめでとうございます！あなたを#{cat.name}の里親に決定しました。",
    body: "#{cat.name}の飼い主の#{cat.user.name}さんが、あなたを#{cat.name}の里親に決定しました。
          今後#{cat.name}の譲渡を無事に行えるよう、リンク先のチャットルームにて#{cat.user.name}さんと話し合いをしましょう。",
    url: Rails.application.routes.url_helpers.chatroom_path(candidate.chatroom.id)
  )

  return { cat: cat, candidate: candidate }
end


# 10, 募集終了
def test_cat_10(publisher_id, candidater_id)
  obj = test_cat_9(publisher_id, candidater_id)

  cat = obj[:cat]
  candidate = obj[:candidate]

  cat.publication_title = 'テスト掲載：募集終了'
  # 掲載ステータスを「募集終了」にする
  cat.update(publication_status: 'recruitment_closed')
  # 立候補ステータスを「譲渡完了」にする
  candidate.update(status: 'transfer_completed')
  # 自動メッセージを送信
  Message.create_and_send(
    user_id: candidate.user.id,
    chatroom_id: candidate.chatroom.id,
    body: "※こちらは自動送信メッセージです

          #{cat.name}を無事に受け取りました！

          今後は#{cat.name}の様子や安否のご連絡を定期的にお話しさせていただきます。
          今回の件、一旦ありがとうございました！

          引き続きよろしくお願いします。"
  )
  # 相手に通知を送信
  Notice.create(
    user_id: cat.user.id,
    title: "#{candidate.user.name}さんが#{cat.name}の受け取りを完了しました。",
    body: "#{candidate.user.name}さんが、あなたから無事に#{cat.name}の受け取りを完了したそうです！一旦お疲れ様でした！
          今後もチャットルームにて相手から、#{cat.name}の様子や安否のお話をお伺いください。",
    url: Rails.application.routes.url_helpers.chatroom_path(candidate.chatroom.id)
  )
end


# 11, 掲載締め切り
def test_cat_11(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：掲載締め切り'
  cat.publication_deadline = Time.zone.now
  cat.save(validate: false)
end

# 12, コメント有り
def test_cat_12(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：コメント有り'

  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end
  cat.save!

  5.times do |index|
    # 掲載にコメント
    comment = cat.comments.create!(
      user_id: rand(17..31),
      body: 'これはテストコメントです。

            これはテストコメントです。これはテストコメントです。


            これはテストコメントです。これはテストコメントです。これはテストコメントです。
            これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。

            これはテストコメントです。'
    )

    # 掲載者への通知を作成
    Notice.create(
      user_id: comment.cat.user.id,
      title: "#{comment.cat.name}の里親募集の掲載にコメントがありました",
      body: "コメントユーザー：#{comment.user.name}
            内容：#{comment.body}",
      url: Rails.application.routes.url_helpers.cat_comments_path(comment.cat.id)
    )
  end

  # 掲載者本人がコメント
  comment = cat.comments.create!(
    user_id: publisher_id,
    body: 'これはテストコメントです。

          これはテストコメントです。これはテストコメントです。


          これはテストコメントです。これはテストコメントです。これはテストコメントです。
          これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。これはテストコメントです。

          これはテストコメントです。'
  )

  # 通知を作成
  #受信者ID（一意なユーザーIDの配列）
  recipients_id = cat.comments.where.not(user_id: publisher_id).pluck(:user_id).uniq
  recipients_id.each do |recipient_id|
    # 通知を作成
    Notice.create(
      user_id: recipient_id,
      title: "あなたがコメントした#{comment.cat.name}の里親募集の掲載にコメントがありました",
      body: "コメントユーザー：#{comment.user.name}
            内容：#{comment.body}",
      url: Rails.application.routes.url_helpers.cat_comments_path(comment.cat.id)
    )
  end
end

# 13, 削除済み掲載
def test_cat_13(publisher_id)
  cat = initial_test_cat(publisher_id)
  cat.publication_title = 'テスト掲載：削除済み掲載'

  3.times do |index|
    img_num = rand(1..10)
    cat.photos.attach(io: File.open(Rails.root.join("app/assets/images/cats/img-#{img_num}.jpg")), filename: "#{img_num}.jpg")
  end

  cat.update(deleted_flag: true)
  cat.save!
end


# IDが2~11の会員は上記掲載を投稿
# IDが12~21の会員は特定の掲載に里親募集
10.times do |index|
  puts "Catモデルのレコードを作成（#{index + 1}/10）"

  publisher_id = index + 2
  candidater_id = rand(12..21)

  test_cat_1(publisher_id)

  case rand(0..1)
  when 0 then
    test_cat_2(publisher_id)
  when 1 then
    test_cat_3(publisher_id)
  end

  test_cat_4(publisher_id)

  case rand(0..2)
  when 0 then
    test_cat_5(publisher_id)
  when 1 then
    test_cat_6(publisher_id)
  when 2 then
    test_cat_7(publisher_id)
  end

  test_cat_8(rand(2..11), candidater_id)
  test_cat_9(rand(2..11), candidater_id)
  test_cat_10(rand(2..11), candidater_id)
  test_cat_11(publisher_id)
  test_cat_12(publisher_id)
  test_cat_13(publisher_id)
end