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

  def choose
    Pusher['slideshow'].trigger('choose', {
      e_id: param[:event_id],
      ss_id: param[:id]
    }) 
    respond_with result: :chosen
  end
end
