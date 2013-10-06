class SlideshowController < ApplicationController

	def index
		@shows = Slideshow.all
	end

	def show
		@ss = Slideshow.find(params[:id])
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
