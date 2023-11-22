// スクロールの上下でクラスを切り替える
window.addEventListener('DOMContentLoaded', () => {
  header(); //ヘッダー
  pageTopButton(); //ページトップボタン
});

// ヘッダー
function header() {
  const header = document.querySelector('#header');
  const hamburgerMenu = document.querySelector('#hamburger-menu');
  let currentPosition = 0;

  window.addEventListener('scroll', () => {
    if (!hamburgerMenu.classList.contains('js-active')) {
      if (currentPosition < document.documentElement.scrollTop) {
        if (currentPosition > 120) {
          header.classList.add('js-hidden');
        }
      } else {
        header.classList.remove('js-hidden');
      }
    }
    currentPosition = document.documentElement.scrollTop;
  });
}

// ページトップボタン
function pageTopButton() {
  const pageTopButton = document.querySelector('#page-top-button');
  let currentPosition = 0;

  window.addEventListener('scroll', () => {
    if (currentPosition < document.documentElement.scrollTop) {
      if (currentPosition > 120) {
        pageTopButton.classList.add('js-show');
      }
    } else {
      pageTopButton.classList.remove('js-show');
    }
    currentPosition = document.documentElement.scrollTop;
  });
}