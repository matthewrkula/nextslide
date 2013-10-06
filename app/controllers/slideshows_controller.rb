class SlideshowsController < ApplicationController
  def index
    @slideshows = Slideshow.all
  end

  def show
    @slideshow = Slideshow.find(params[:id])
  end

  def forward
    Pusher['slideshow'].trigger('forward', {
      message: 'hello world'
    }) 
  end

  def backward
    Pusher['slideshow'].trigger('backward', {
      message: 'hello world'
    }) 
  end
end
