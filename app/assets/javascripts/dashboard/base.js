window.onload = function() {
  console.log('worked!');
  var slideshowsList = document.getElementById('slideshows-list'),
      slideshowsListChildren = slideshowsList.children,
      slideshowListItems = [],
      i;

  for (i = 0; i < slideshowsList.children.length; i++) {
    if (slideshowsListChildren[i].className == 'slideshow-item')
      slideshowListItems.push(slideshowsListChildren[i]);
  }

  for (i = 0; i < slideshowListItems.length; i++) {
    (function(_i){
      slideshowListItems[_i].onmouseover = function(e) {
        slideshowListItems[_i].
        console.log(slideshowListItems[_i]);
      }
    })(i);
  }
};
