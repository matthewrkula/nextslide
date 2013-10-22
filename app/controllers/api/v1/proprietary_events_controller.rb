class Api::V1::ProprietaryEventsController < Api::V1::BaseController
  def index
    @proprietary_events = current_user.proprietary_events
  end

  def show
    @proprietary_event = current_user.proprietary_events.find(params[:id])
  end
end
