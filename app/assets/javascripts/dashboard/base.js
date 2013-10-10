window.onload = function() {
  console.log('worked!');
  var slideshowsList = document.getElementById('slideshows-list'),
      slideshowListItems = slideshowsList.children,
      i;
  for (i = 0; i < slideshowListItems.length; i++) {
  console.log(slideshowListItems[i]);
    slideshowListItems[i].onmouseover = function(e) {
      console.log(slideshowListItems[i]);
      //slideshowListItems[i].style.display = 'none';
    };
  }
};
