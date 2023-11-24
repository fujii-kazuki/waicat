// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";

Rails.start()
// Turbolinks.start() #Turbolinksを無効にする
ActiveStorage.start()

import '../features/hamburger-toggle' //ハンバーガーメニューによる開閉機能
import '../features/class-toggle-scroller' //スクロールによる要素のクラス名の切り替え
import '../features/page-top-smooth-scroll' //ページトップボタン機能
import '../features/search-address' //住所検索機能
import '../features/carousel' //カルーセル機能
import '../features/file-uploader' //ファイルアップロード機能
import '../features/chatroom-auto-scroller' //チャットルームのメッセージ受信時の自動スクロール