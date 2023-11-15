window.addEventListener('DOMContentLoaded', () => {
  const pageTopButton = document.querySelector('#page-top-button');

  pageTopButton.addEventListener('click', () => {
    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  });
});