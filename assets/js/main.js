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

// Who we are
const whoWeAreButton = document.getElementById('who-we-are-nav-item');
const whoWeAreMenu = document.getElementById('who-we-are-nav-item-menu');


let whoWeAreButtonTimeout = null;
let whoWeAreMenuTimeout = null;

whoWeAreButton.addEventListener('mouseover', () => {
  clearTimeout(whoWeAreMenuTimeout);
  whoWeAreMenu.classList.remove('hidden');
});
whoWeAreButton.addEventListener('mouseout', () => {
  whoWeAreButtonTimeout = setTimeout(() => {
	whoWeAreMenu.classList.add('hidden');
  }, 200);
});

whoWeAreMenu.addEventListener('mouseover', () => {
  clearTimeout(whoWeAreButtonTimeout);
});
whoWeAreMenu.addEventListener('mouseout', function(event) {
  var e = event.toElement || event.relatedTarget;
  if (e.parentNode == this || e == this) {
	 return;
  }
  whoWeAreMenuTimeout = setTimeout(() => {
	whoWeAreMenu.classList.add('hidden');
  }, 200);
}, true);

// Affiliation
const affiliatesButton = document.getElementById('affiliates-nav-item');
const affiliatesMenu = document.getElementById('affiliates-nav-item-menu');


let affiliatesButtonTimeout = null;
let affiliatesMenuTimeout = null;

affiliatesButton.addEventListener('mouseover', () => {
  clearTimeout(affiliatesMenuTimeout);
  affiliatesMenu.classList.remove('hidden');
});
affiliatesButton.addEventListener('mouseout', () => {
  affiliatesButtonTimeout = setTimeout(() => {
	affiliatesMenu.classList.add('hidden');
  }, 200);
});

affiliatesMenu.addEventListener('mouseover', () => {
  clearTimeout(affiliatesButtonTimeout);
});
affiliatesMenu.addEventListener('mouseout', function(event) {
  var e = event.toElement || event.relatedTarget;
  if (e.parentNode == this || e == this) {
	 return;
  }
  affiliatesMenuTimeout = setTimeout(() => {
	affiliatesMenu.classList.add('hidden');
  }, 200);
}, true);


// News
const newsButton = document.getElementById('news-nav-item');
const newsMenu = document.getElementById('news-nav-item-menu');


let newsButtonTimeout = null;
let newsMenuTimeout = null;

newsButton.addEventListener('mouseover', () => {
  clearTimeout(newsMenuTimeout);
  newsMenu.classList.remove('hidden');
});
newsButton.addEventListener('mouseout', () => {
  newsButtonTimeout = setTimeout(() => {
	newsMenu.classList.add('hidden');
  }, 200);
});

newsMenu.addEventListener('mouseover', () => {
  clearTimeout(newsButtonTimeout);
});
newsMenu.addEventListener('mouseout', function(event) {
  var e = event.toElement || event.relatedTarget;
  if (e.parentNode == this || e == this) {
	 return;
  }
  newsMenuTimeout = setTimeout(() => {
	newsMenu.classList.add('hidden');
  }, 200);
}, true);
