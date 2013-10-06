class UploadController < ApplicationController


	def upload
	end

	def submit
		url = params[:url]

		ss = Slideshow.new({url: url, slide_num: 3})
		ss.save!

		respond_to do |format|
			format.js
		end
	end

end
