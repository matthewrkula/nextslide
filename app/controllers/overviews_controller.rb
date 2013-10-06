class OverviewsController < ApplicationController
  layout 'plain'

  def index
  end

  def trigger
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    }) 
  end
end
