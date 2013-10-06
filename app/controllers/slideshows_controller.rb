class SlideshowsController < ApplicationController
  before_filter :setup_event

  def index
    @slideshows = @event.slideshows
  end

  def show
    @slideshow = @event.slideshows.find(params[:id])
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

  def choose
    Pusher['slideshow'].trigger('choose', {
      e_id: params[:event_id],
      ss_id: params[:id]
    }) 
    # respond_with result: :chosen
  end

  def new
    # @event.slideshows.build
  end

	def create
		url = params[:url]
		event_id = @event.id
		name = params[:name]

		response = RestClient.get("http://api.shabz.co/hackathon/get_page_count.php?url=http://docs.google.com/gview?url=#{url}&embedded=true&chrome=false")
		num_pages = JSON.parse(response.body)['num_pages']

		ss = Slideshow.new({url: url, slide_num: num_pages, event_id: event_id, name: name})
		ss.save!

    i = 0
    while (i < num_pages.to_i) do
      ss.slides.create!({ slide_number: i + 1 })
      i = i + 1
    end

    @slideshow = ss

		respond_to do |format|
			format.js
		end
	end

private

  def setup_event
    @event = Event.find(params[:event_id])
  end
end
