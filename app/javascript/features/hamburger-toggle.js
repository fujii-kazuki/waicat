window.addEventListener('DOMContentLoaded', () => {
  const hamburgerMenu = document.querySelector('#hamburger-menu');
  const spNavMenu = document.querySelector('#sp-nav-menu');

  hamburgerMenu.addEventListener('click', (e) => {
    hamburgerMenu.classList.toggle('js-active');
    spNavMenu.classList.toggle('js-open');
  });
});