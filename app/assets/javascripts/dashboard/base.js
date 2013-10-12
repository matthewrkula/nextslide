(function() {
  window.onload = function() {
    var bodyElement = document.getElementsByTagName('body')[0];
    if (bodyElement && bodyElement.id.match(/events-controller/) && bodyElement.className.match(/show-action/)) {
      var self = this,
          slideshowsList = document.getElementById('slideshows-list'),
          slideshowsListChildren = slideshowsList.children,
          slideshowListItems = [],
          i, j;

      for (i = 0; i < slideshowsList.children.length; i++) {
        if (slideshowsListChildren[i].className.match(/slideshow-item/g))
          slideshowListItems.push(slideshowsListChildren[i]);
      }

      for (i = 0; i < slideshowListItems.length; i++) {
        (function(_i) {
          var tempUrl, tempChildren, tempEditLink;

          tempChildren = slideshowListItems[_i].children;
          for (j = 0; j < slideshowListItems[_i].children.length; j++) {
            if (slideshowListItems[_i].children[j].className.match(/slideshow-url/g))
              tempUrl = slideshowListItems[_i].children[j].innerHTML;
            if (slideshowListItems[_i].children[j].className.match(/slideshow-item-edit-link/g))
              tempEditLink = slideshowListItems[_i].children[j];
          }

          slideshowListItems[_i].onclick = function(e) {
            window.location.href = tempUrl;
          };

          slideshowListItems[_i].onmouseover = function(e) {
            tempEditLink.style.display = 'block';
          };

          slideshowListItems[_i].onmouseout = function(e) {
            tempEditLink.style.display = 'none';
          };
        })(i);
      }
    }
  };
})();
