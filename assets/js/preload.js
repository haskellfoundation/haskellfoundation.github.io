// INTENTIONALLY BLOCKING
function preloadTheme() {
  const DARK = 'dark';
  const LIGHT = 'light';

  const bodyClassList = document.body.classList;
  const makeDark = localStorage.getItem(DARK) === 'true';
  if (makeDark) {
    bodyClassList.remove(LIGHT);
    bodyClassList.add(DARK);
  } else {
    bodyClassList.remove(DARK);
    bodyClassList.add(LIGHT);
  }
}
