// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require pusher_example
//= require_tree .

var init = function() {
  var slidesContainer, slides, currentIndex, i, currentZIndex, backStageZIndex, onDeckZIndex, nextButton, previousButton;
  slidesContainer = document.getElementById('slides-container');
  slidesContainer.style.position = 'relative';
  slides = slidesContainer.children;
  currentIndex = 0;
  currentZIndex = 1000;
  backStageZIndex = -1000;
  onDeckZIndex = currentZIndex - 1;
  nextButton = document.getElementById('next-button');
  previousButton = document.getElementById('previous-button');
  if (slides.length > 0) {
    slides[0].style.position = 'absolute';
    slides[0].style.zIndex = currentZIndex;
    slides[0].style.top = 0;
    slides[0].style.left = 0;
    slides[0].style.backgroundColor = 'white';
    console.log(0);
    for (i = 1; i < slides.length; i++) {
      slides[i].style.position = 'absolute';
      slides[i].style.zIndex = backStageZIndex;
      slides[i].style.top = 0;
      slides[i].style.left = 0;
      slides[i].style.backgroundColor = 'white';
      console.log('i: ' + i);
    }
  }

  var getCurrentSlide = function() {
    return slides[currentIndex];
  };

  var getNextIndex = function() {
    return currentIndex + 1;
  };

  var getPreviousIndex = function() {
    return currentIndex - 1;
  };

  var getPreviousSlide = function() {
    return slides[getPreviousIndex()];
  };

  var getNextSlide = function() {
    return slides[getNextIndex()];
  };

  var isNextIndexOutOfBounds = function() {
    return getNextIndex() == slides.length;
  };

  var isPreviousIndexOutOfBounds = function() {
    return getPreviousIndex() == -1;
  };

  var goToPreviousSlide = function() {
    if (isPreviousIndexOutOfBounds()) {
      getLastSlide().style.zIndex = onDeckZIndex;
      getCurrentSlide().style.zIndex = backStageZIndex;
      getLastSlide().style.zIndex = currentZIndex;
      currentIndex = getLastIndex();
      console.log("WRAPPING to last");
    } else {
      getPreviousSlide().style.zIndex = onDeckZIndex;
      getCurrentSlide().style.zIndex = backStageZIndex;
      getPreviousSlide().style.zIndex = currentZIndex;
      currentIndex--;
    }
  };

  var getFirstIndex = function() {
    return 0; 
  };

  var getFirstSlide = function() {
    return slides[getFirstIndex()];
  };

  var getLastIndex = function() {
    return slides.length - 1;
  };

  var getLastSlide = function() {
    return slides[getLastIndex()];
  };

  var goToNextSlide = function() {
    if (isNextIndexOutOfBounds()) {
      getFirstSlide().style.zIndex = onDeckZIndex;
      getCurrentSlide().style.zIndex = backStageZIndex;
      getFirstSlide().style.zIndex = currentZIndex;
      currentIndex = getFirstIndex();
      console.log("WRAPPING to first");
    } else {
      getNextSlide().style.zIndex = onDeckZIndex;
      getCurrentSlide().style.zIndex = backStageZIndex;
      getNextSlide().style.zIndex = currentZIndex;
      currentIndex++;
    }
  };

  nextButton.onclick = function(e) {
    if (e) e.preventDefault();
    goToNextSlide();
  };

  previousButton.onclick = function(e) {
    if (e) e.preventDefault();
    goToPreviousSlide();
  };

  console.log(getCurrentSlide());
};

window.onload = init;
