import Swiper from 'swiper/swiper-bundle';
import 'swiper/swiper-bundle.min.css';

window.addEventListener('DOMContentLoaded', () => {
  publishCarousel(); //掲載詳細ページのカルーセル
});

// 掲載詳細ページのカルーセル
function publishCarousel() {
  // ページに要素がなければここで処理を終了
  if (!document.querySelector('#publish-swiper')) return;

  const thumbsSlider = new Swiper('#publish-thumbs-slider', {
    loop: true,
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