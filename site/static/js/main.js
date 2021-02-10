const openButton = document.getElementById('mobile-nav-open');
const closeButton = document.getElementById('mobile-nav-close');
const backdrop = document.getElementById('nav-backdrop');
const mobileNav = document.getElementById('mobile-nav');

const openNav = () => {
  document.body.classList.add('overflow-hidden');
  backdrop.classList.remove('hidden');
  mobileNav.classList.remove('hidden');
}

const closeNav = () => {
  document.body.classList.remove('overflow-hidden');
  backdrop.classList.add('hidden');
  mobileNav.classList.add('hidden');
}

openButton.addEventListener('click', openNav);
closeButton.addEventListener('click', closeNav);
backdrop.addEventListener('click', closeNav);
