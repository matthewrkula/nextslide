class SlideshowsController < ApplicationController
  layout :resolve_layout
  before_filter :setup_event

  def index
    @slideshows = @event.slideshows
  end

  def show
    @slideshow = @event.slideshows.find(params[:id])
    @event_id = params[:event_id]
    @id = params[:id]
  end

  def forward
    @channel = "event-#{params[:event_id]}-slideshow-#{params[:id]}"
    Pusher[@channel].trigger('forward', {
      message: 'hello world'
    }) 
  end

  def backward
    @channel = "event-#{params[:event_id]}-slideshow-#{params[:id]}"
    Pusher[@channel].trigger('backward', {
      message: 'hello world'
    }) 
  end

  def choose
    Pusher["slideshow"].trigger('choose', {
      e_id: params[:event_id],
      ss_id: params[:id]
    }) 
  end

  def new
    @slideshow = @event.slideshows.build
  end

	def create
    @slideshow = @event.slideshows.build(params[:slideshow])
    if @slideshow.save
      response_object = RestClient.get("http://api.shabz.co/hackathon/get_page_count.php?url=http://docs.google.com/gview?url=#{@slideshow.url.url}&embedded=true&chrome=false")
      num_pages = JSON.parse(response_object.body)['num_pages']
      @slideshow.slide_num = num_pages
      @slideshow.save
      i = 0
      while (i < num_pages.to_i) do
        @slideshow.slides.create!({ slide_number: i + 1 })
        i = i + 1
      end
      redirect_to event_url(@event), notice: 'Created a slideshow successfully.'
    else
      render :new
    end
	end

private

  def setup_event
    @event = Event.find(params[:event_id])
  end

  def resolve_layout
    case action_name
    when 'show'
      'slideshow'
    else
      'dashboard'
    end
  end
end
