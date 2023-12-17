##################################################################

# 会員

##################################################################

# これらは架空のデータであり、実在の電話番号メールアドレス、郵便番号、住所ではありません。
users = [
  { name: '佐藤大輝', telephone_number: '09012345678', email: 'satohiroki@example.com', postal_code: '1234567', prefecture: '東京都', city: '千代田区一丁目1-1', password: 'password' },
  { name: '鈴木悠斗', telephone_number: '08023456789', email: 'suzukiyuto@example.com', postal_code: '2345678', prefecture: '大阪府', city: '大阪市中央区二丁目2-2', password: 'password' },
  { name: '高橋健太', telephone_number: '07034567890', email: 'takahashikenta@example.com', postal_code: '3456789', prefecture: '神奈川県', city: '横浜市西区三丁目3-3', password: 'password' },
  { name: '田中拓真', telephone_number: '08098765432', email: 'tanakatakuma@example.com', postal_code: '4567890', prefecture: '愛知県', city: '名古屋市南区四丁目4-4', password: 'password' },
  { name: '渡辺慎一', telephone_number: '09087654321', email: 'watanabeshinichi@example.com', postal_code: '5678901', prefecture: '福岡県', city: '福岡市東区五丁目5-5', password: 'password' },
  { name: '伊藤悠太', telephone_number: '07011112222', email: 'itoyuta@example.com', postal_code: '6789012', prefecture: '北海道', city: '札幌市北区六丁目6-6', password: 'password' },
  { name: '山本啓太', telephone_number: '08033334444', email: 'yamamotokeita@example.com', postal_code: '7890123', prefecture: '京都府', city: '京都市左京区七丁目7-7', password: 'password' },
  { name: '中村裕太', telephone_number: '09055556666', email: 'nakamurayuta@example.com', postal_code: '8901234', prefecture: '兵庫県', city: '神戸市東灘区八丁目8-8', password: 'password' },
  { name: '小林将太', telephone_number: '07077778888', email: 'kobayamashota@example.com', postal_code: '9012345', prefecture: '埼玉県', city: 'さいたま市南区九丁目9-9', password: 'password' },
  { name: '加藤雅人', telephone_number: '08099990000', email: 'katomasa@example.com', postal_code: '0123456', prefecture: '千葉県', city: '千葉市美浜区十丁目10-10', password: 'password' },
  { name: '吉田悠介', telephone_number: '09011112222', email: 'yoshidayusuke@example.com', postal_code: '1239876', prefecture: '愛媛県', city: '松山市中央区十一丁目11-11', password: 'password' },
  { name: '山田康太', telephone_number: '07033334444', email: 'yamadayasutaka@example.com', postal_code: '2347890', prefecture: '岡山県', city: '岡山市北区十二丁目12-12', password: 'password' },
  { name: '佐々木陽一', telephone_number: '08055556666', email: 'sasakiyoichi@example.com', postal_code: '3456789', prefecture: '広島県', city: '広島市西区十三丁目13-13', password: 'password' },
  { name: '木村拓也', telephone_number: '09077778888', email: 'kimuratakuya@example.com', postal_code: '4565678', prefecture: '沖縄県', city: '那覇市南区十四丁目14-14', password: 'password' },
  { name: '山口大輔', telephone_number: '07099990000', email: 'yamaguchidaisuke@example.com', postal_code: '5674567', prefecture: '新潟県', city: '新潟市東区十五丁目15-15', password: 'password' },
  { name: '佐藤美咲', telephone_number: '08011112222', email: 'satomisaki@example.com', postal_code: '6783456', prefecture: '青森県', city: '青森市西区十六丁目16-16', password: 'password' },
  { name: '鈴木真由美', telephone_number: '09033334444', email: 'suzukimayumi@example.com', postal_code: '7892345', prefecture: '石川県', city: '金沢市南区十七丁目17-17', password: 'password' },
  { name: '高橋愛子', telephone_number: '07055556666', email: 'takahashiako@example.com', postal_code: '8901234', prefecture: '長野県', city: '長野市北区十八丁目18-18', password: 'password' },
  { name: '田中千紗', telephone_number: '08077778888', email: 'tanakachisa@example.com', postal_code: '9010123', prefecture: '福島県', city: '福島市東区十九丁目19-19', password: 'password' },
  { name: '渡辺結衣', telephone_number: '09099990000', email: 'watanabeyui@example.com', postal_code: '0123456', prefecture: '岩手県', city: '盛岡市西区二十丁目20-20', password: 'password' },
  { name: '伊藤美香', telephone_number: '07011112222', email: 'itomika@example.com', postal_code: '1234567', prefecture: '静岡県', city: '静岡市葵区二十一丁目21-21', password: 'password' },
  { name: '山本佳子', telephone_number: '08033334444', email: 'yamamotokayoko@example.com', postal_code: '2345678', prefecture: '愛知県', city: '豊田市西区二十二丁目22-22', password: 'password' },
  { name: '中村綾乃', telephone_number: '09055556666', email: 'nakamurayanano@example.com', postal_code: '3456789', prefecture: '京都府', city: '京都市伏見区二十三丁目23-23', password: 'password' },
  { name: '小林亜美', telephone_number: '07077778888', email: 'kobayashiami@example.com', postal_code: '4567890', prefecture: '広島県', city: '広島市東区二十四丁目24-24', password: 'password' },
  { name: '加藤優美', telephone_number: '08099990000', email: 'katoyumi@example.com', postal_code: '5678901', prefecture: '北海道', city: '札幌市西区二十五丁目25-25', password: 'password' },
  { name: '吉田香奈', telephone_number: '09011112222', email: 'yoshidakana@example.com', postal_code: '6789012', prefecture: '宮城県', city: '仙台市青葉区二十六丁目26-26', password: 'password' },
  { name: '山田佳子', telephone_number: '07033334444', email: 'yamadakako@example.com', postal_code: '7890123', prefecture: '福岡県', city: '北九州市戸畑区二十七丁目27-27', password: 'password' },
  { name: '佐々木奈々', telephone_number: '08055556666', email: 'sasakinana@example.com', postal_code: '8901234', prefecture: '熊本県', city: '熊本市中央区二十八丁目28-28', password: 'password' },
  { name: '木村彩香', telephone_number: '09077778888', email: 'kimurayuka@example.com', postal_code: '9012345', prefecture: '千葉県', city: '船橋市二十九丁目29-29', password: 'password' },
  { name: '山口真理', telephone_number: '07099990000', email: 'yamaguchimari@example.com', postal_code: '0123456', prefecture: '兵庫県', city: '尼崎市東区三十丁目30-30', password: 'password' }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |end_user|
    puts "Userモデルのレコード作成"

    end_user.name = user[:name]
    end_user.telephone_number = user[:telephone_number]
    end_user.email = user[:email]
    end_user.postal_code = user[:postal_code]
    end_user.prefecture = user[:prefecture]
    end_user.city = user[:city]
    end_user.password = user[:password]
  end
end