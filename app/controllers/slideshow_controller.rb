class SlideshowController < ApplicationController

	def show
		@ss = Slideshow.find(params[:id])
	end

end
