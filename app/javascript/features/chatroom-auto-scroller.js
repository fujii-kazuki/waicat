window.addEventListener('DOMContentLoaded', () => {
  // メッセージリスト
  const messageList = document.querySelector('#message-list');
  // ページに要素がなければ処理を終了
  if (!messageList) return;

  // メッセージリストを最下部まで自動スクロールするメソッド
  messageList.scrollToBottom = function() {
    this.scroll(0, this.scrollHeight);
  };

  // コールバック関数に結びつけられたオブザーバーのインスタンスを生成
  const observer = new MutationObserver(messageList.scrollToBottom.bind(messageList));

  // メッセージリストの変更の監視を開始
  observer.observe(messageList, { childList: true });

  // メッセージリストを最下部まで自動スクロール
  messageList.scrollToBottom();
});