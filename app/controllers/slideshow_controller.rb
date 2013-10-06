class SlideshowController < ApplicationController
  respond_to :html, :json

  def index
    @shows = Slideshow.all
  end

  def show
    @ss = Slideshow.find(params[:id])
    respond_with html: @ss
  end

  def forward
    Pusher['slideshow'].trigger('forward', {
      message: 'hello world'
    }) 
    respond_with result: :forwarded
  end

  def backward
    Pusher['slideshow'].trigger('backward', {
      message: 'hello world'
    }) 
    respond_with result: :backwarded
  end
end
