window.addEventListener('DOMContentLoaded', () => {
  // アコーディオン要素
  const accordion = document.querySelector('#accordion');
  if (!accordion) return; //ページ内に要素がなければ処理を終了
  
  // アコーディオンのヘッダー要素
  accordion.head = document.querySelector('#accordion-head');
  // 「開く」or「閉じる」の要素
  accordion.openOrCloseText = document.querySelector('#accordion-open-or-close-text');
  // アコーディオンのアイコン要素
  accordion.icon = document.querySelector('#accordion-icon');
  // アコーディオンの内容要素
  accordion.body = document.querySelector('#accordion-body');

  // ヘッダーにクリックイベントを追加
  accordion.head.addEventListener('click', toggleAccordion.bind(accordion));

  // アコーディオンの開閉
  function toggleAccordion() {
    this.openOrCloseText.innerText = this.openOrCloseText.innerText === '開く' ? '閉じる' : '開く';
    this.icon.classList.toggle('cats-search__accordion-head-icon--down');
    this.body.classList.toggle('cats-search__accordion-body--open');
  }
});