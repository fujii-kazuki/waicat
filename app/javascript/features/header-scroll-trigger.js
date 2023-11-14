window.addEventListener('DOMContentLoaded', () => {
  const header = document.querySelector('#header');
  const hamburgerMenu = document.querySelector('#hamburger-menu');
  let currentPosition = 0;

  window.addEventListener('scroll', (e) => {
    if (!hamburgerMenu.classList.contains('js-active')) {
      if (currentPosition < document.documentElement.scrollTop) {
        if (currentPosition > 100) {
          header.classList.add('js-hidden');
        }
      } else {
        header.classList.remove('js-hidden');
      }
    }
    currentPosition = document.documentElement.scrollTop;
  });
});