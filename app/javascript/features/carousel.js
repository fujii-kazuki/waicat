import Swiper from 'swiper/swiper-bundle';
import 'swiper/swiper-bundle.min.css';

window.addEventListener('DOMContentLoaded', () => {
  publishCarousel(); //掲載詳細ページのカルーセル
  publishEditCarousel(); //掲載編集ページのカルーセル
});

// 掲載詳細ページのカルーセル
function publishCarousel() {
  // ページに要素がなければここで処理を終了
  if (!document.querySelector('#publish-swiper')) return;

  const thumbsSlider = new Swiper('#publish-thumbs-slider', {
    spaceBetween: 10,
    slidesPerView: 4.5,
    freeMode: true,
    watchSlidesProgress: true,
    grabCursor: true,
  });

  const swiper = new Swiper('#publish-swiper', {
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    spaceBetween: 10,
    loop: true,
    grabCursor: true,
    thumbs: {
      swiper: thumbsSlider,
    },
  });
}

// 掲載編集ページのカルーセル
function publishEditCarousel() {
  // ページに要素がなければここで処理を終了
  if (!document.querySelector('#publish-edit-swiper')) return;

  const thumbsSlider = new Swiper('#publish-edit-thumbs-slider', {
    spaceBetween: 10,
    slidesPerView: 4.5,
    freeMode: true,
    watchSlidesProgress: true,
    grabCursor: true,
  });

  const swiper = new Swiper('#publish-edit-swiper', {
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    spaceBetween: 10,
    loop: true,
    grabCursor: true,
    thumbs: {
      swiper: thumbsSlider,
    },
  });

  // 削除ボタンにクリックイベントを追加
  const slideDeleteButtons = document.querySelectorAll('.publish-edit__slide-delete-button');
  slideDeleteButtons.forEach((button) => {
    button.addEventListener('click', (event) => {
      const buttons = document.querySelectorAll('.publish-edit__slide-delete-button');
      buttons.forEach((button, index) => {
        if (button === event.target) {
          // 対応するサムネイルのスライドも削除
          thumbsSlider.removeSlide(index);
          // 削除ボタンの親要素のスライドを削除
          swiper.removeSlide(index);
        }
      });
    });
  });
}