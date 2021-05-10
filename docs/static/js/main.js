// Mobile nav functionality

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

// Desktop nav dropdown functionality

const dropdownButton = document.getElementById('dropdown-nav-item');
const dropdownMenu = document.getElementById('dropdown-nav-item-menu');


let dropdownButtonTimeout = null;
let dropdownMenuTimeout = null;

dropdownButton.addEventListener('mouseover', () => {
  clearTimeout(dropdownMenuTimeout);
  dropdownMenu.classList.remove('hidden');
});
dropdownButton.addEventListener('mouseout', () => {
  dropdownButtonTimeout = setTimeout(() => {
	dropdownMenu.classList.add('hidden');
  }, 200);
});

dropdownMenu.addEventListener('mouseover', () => {
  clearTimeout(dropdownButtonTimeout);
});
dropdownMenu.addEventListener('mouseout', function(event) {
  var e = event.toElement || event.relatedTarget;
  if (e.parentNode == this || e == this) {
	 return;
  }
  dropdownMenuTimeout = setTimeout(() => {
	dropdownMenu.classList.add('hidden');
  }, 200);
}, true);
