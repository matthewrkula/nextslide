class Api::V1::EventsController < Api::V1::BaseController
  def index
    @events = current_user.events
  end

  def show
    @event = Event.find(params[:id])
  end
end
