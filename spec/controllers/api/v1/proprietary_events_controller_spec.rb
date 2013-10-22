require 'spec_helper'

describe Api::V1::ProprietaryEventsController do
  render_views

  it 'should inherit from BaseController' do
    Api::V1::ProprietaryEventsController.ancestors.should include(Api::V1::BaseController)
  end

  let!(:user) { create(:user) }
  let!(:user_api_key) { create(:user_api_key, user: user) }

  before(:each) { controller.stub(:current_user).and_return(user) }

  describe "GET 'index'" do
    let!(:event_one) { create(:event, user: user) }
    let!(:event_two) { create(:event, user: user) }
    let!(:proprietary_events) { [event_one, event_two] }

    before(:each) do
      controller.send(:current_user).should_receive(:proprietary_events).
        and_return(proprietary_events)
      get :index, format: :json
      @parsed_json = JSON.parse(response.body)
    end

    it "should assign the current_user's proprietary_events to @proprietary_events" do
      assigns(:proprietary_events).should == proprietary_events
    end

    it 'should respond only with proprietary events' do
      @parsed_json['response'].each_with_index do |proprietary_event, index|
        [ 'id', 'name' ].each do |field|
          proprietary_event[field].should == proprietary_events[index][field]
        end
        proprietary_event['image'].should == proprietary_events[index].image.url
      end
    end

    it 'should respond with 200' do
      response.status.should == 200
    end
  end

  describe "GET 'show'" do
    let!(:event_one) { create(:event, user: user) }
    let!(:event_two) { create(:event, user: user) }
    let!(:proprietary_events) { [event_one, event_two] }
    let!(:event_one_index) { 0 }

    before(:each) do
      proprietary_events.should_receive(:find).and_return(event_one)
      controller.send(:current_user).should_receive(:proprietary_events).
        and_return(proprietary_events)
      get :show, id: event_one, format: :json
      @parsed_json = JSON.parse(response.body)
    end

    it "should assign the current_user's proprietary_event to @proprietary_event based on id from params" do
      assigns(:proprietary_event).should == event_one
    end

    it 'should set a response object to be for @event object' do
      [ 'id', 'name' ].each do |field|
        @parsed_json['response'][field].should == event_one[field]
      end
      @parsed_json['response']['image'].should == event_one.image.url
    end

    it 'should respond with 200' do
      response.status.should == 200
    end
  end
end
