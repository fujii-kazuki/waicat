# 待ちねこ - waicat

<img style="width: 85%;" src="https://github.com/fujii-kazuki/waicat/assets/142955783/5779822d-95be-4b6d-acbf-93a6f1dc5826">
<img style="width: 13%;" src="https://github.com/fujii-kazuki/waicat/assets/142955783/4d7a4c1c-3545-4828-921c-68e44f554169">
  
## サイト概要
- [サイトテーマ](#サイトテーマ)
  - [テーマを選んだ理由](#テーマを選んだ理由)
  - [ターゲットユーザ](#ターゲットユーザ)
  - [主な利用シーン](#主な利用シーン)
- [設計書](#設計書)
  - [ER図](#er図)
  - [テーブル設計書](#テーブル設計書)
  - [アプリケーション詳細設計書](#アプリケーション詳細設計書)
- [使用技術](#使用技術)
- [機能一覧](#機能一覧)
- [使用画像素材](#使用画像素材)

### サイトテーマ
猫ちゃんの飼い主募集を支援するコミュニティサイト
​
### テーマを選んだ理由  
僕は生まれて26年間、無類の猫好きです。実家では、幼い頃に側溝で迷子になってた猫ちゃんとX(当時Twitter)で飼い主募集として掲載されていた猫ちゃんの2匹が一緒に暮らしています。  

過去に「日本は1994年以来、猫の飼育数が犬を上回る空前の猫ブームが来ている」というニュースを見ました。ブームは良い事ですが、流行りという理由で飼育を始める方も増えるのも事実でしょう。そしてそのブームが去った時、売れ残った猫ちゃん、捨てられる猫ちゃんがどうなるか想像ができると思います。  

ペットの保護施設に依頼するのも一つの手ですが、ネット社会の現在、多くの目が集まるWebを活用すれば、個人でも飼い主募集活動を行う事ができ、  

- 「1匹でも多くの猫ちゃんに居場所を与えられるのではないか」
- 「元飼い主、新しい飼い主の方にも安心を与える事が出来るのではないか」

このような考えから、上記テーマのWebアプリを開発しようと思いました。
​
### ターゲットユーザ
- 飼い主の都合や望まぬ子猫の出産、迷い猫ちゃんなどにより、猫ちゃんの飼い主を募集したい人
- 真剣な気持ちで猫ちゃんのお世話をしたい、1匹でも居場所を与えてあげたいと考えてる人
​
### 主な利用シーン
- 猫ちゃんの飼い主の募集する時
- 飼い猫を募集、検索時
- 飼い主候補と飼い猫ちゃんの譲渡についての相談時
​
## 設計書

### ER図
![ER](https://github.com/fujii-kazuki/waicat/assets/142955783/4bfd1d9c-847f-4264-b339-49b67c333977)

### テーブル設計書
https://docs.google.com/spreadsheets/d/1MabnBQgrqwucpTfdZOK9WKm8-InxjHh0/edit#gid=22058163

### アプリケーション詳細設計書
https://docs.google.com/spreadsheets/d/1XBAAwcyST-mEpkTHLLL2FVesoSUJ39IeSXmJweubW5c/edit#gid=549108681
​
## 使用技術
- HTML5 / CSS3
- Sass
- JavaScript
- Node.js(npm)
- Ruby 3.1.2
- Ruby on Rails 6.1.7
- Nginx
- Puma
- AWS
  - Cloud9
  - EC2
  - RDS
- Docker 4.24.2
- Visual Studio Code
- [郵便番号検索API](https://zipcloud.ibsnet.co.jp/doc/api)

## 機能一覧
- 新規登録・ログイン・ログアウト・退会（Gem devise）
- ゲストログイン
- 会員情報編集
  - アバター画像投稿・プレビュー・削除（Gem ActiveStorageValidations）
- 投稿
  - 動画・複数画像投稿・プレビュー・削除（Gem ActiveStorageValidations）
  - 添付画像のサムネイル付きカルーセル（npm Swiper）
  - 下書き保存
  - 投稿掲載期限設定
- 住所自動入力（郵便番号検索API）
- 投稿検索（Gem Ransack）
  - キーワード検索
  - カテゴリー検索
- ブックマーク登録・解除（Ajax）
- コメント投稿・削除（Ajax）
- ページネーション（Gem kaminari）
- 里親立候補・決定・お断り
- リアルタイムチャット（Ajax, ActionCable）
- 通知未読・既読・ソート
- お問い合せ
- レスポンシブ対応

## 使用画像素材
- [photoAC](https://www.photo-ac.com/)
- [ICOOON MONO](https://icooon-mono.com/)
