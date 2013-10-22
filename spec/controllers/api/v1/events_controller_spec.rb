require 'spec_helper'

describe Api::V1::EventsController do
  render_views

  it 'should inherit from BaseController' do
    Api::V1::ProprietaryEventsController.ancestors.should include(Api::V1::BaseController)
  end

  let!(:user) { create(:user) }

  before(:each) do
    controller.stub(:current_user).and_return(user)
  end

  describe 'GET index' do
    let!(:another_user) { create(:user) }
    let!(:event_one) { create(:event, user: user) }
    let!(:someone_elses_event) { create(:event, user: another_user) }
    let!(:event_two) { create(:event, user: user) }
    let!(:events) { [event_one, event_two] }

    it "should assing only current_user's #events" do
      get :index, format: :json
      assigned_events = assigns(:events)
      assigned_events.length.should == 2
      assigned_events.each do |assigned_event|
        events.should include(assigned_event)
      end
    end

    # context 'after stubbing events for easier testing' do
    #   before(:each) do
    #     user.should_receive(:events).and_return(events)
    #     get :index, format: :json
    #   end

    #   it 'should assign ' do

    #   end
    # end




    # context 'when authorization token is provided' do
    #   let!(:another_user) { create(:user) }
    #   let!(:event_one) { create(:event, user: user) }
    #   let!(:someone_elses_event) { create(:event, user: another_user) }
    #   let!(:event_two) { create(:event, user: user) }

    #   it 'should call #events on the current_user object' do
    #     controller.current_user.should_receive(:events).and_return()        
    #   end

    #   it 'should respond with 200' do
    #     get :index, format: :json
    #     response.status.should == 200
    #   end

    #   it 'should contain only events that belong to that user' do
    #     pending 
    #   end

    #   it 'should assing events' do
    #     pending 
    #   end
    # end

    # context 'when authorization token is not provided' do
    #   let!(:event_one) { create(:event) }
    #   let!(:event_two) { create(:event) }
    #   let!(:fake_all_events) { [event_one, event_two] }

    #   before(:each) do
    #     Event.should_receive(:all).and_return(fake_all_events)
    #     get :index, format: :json
    #     @parsed_response = JSON.parse(response.body)['response']
    #   end

    #   it 'should respond with 200' do
    #     response.status.should == 200 
    #   end

    #   it 'should assign all Event objects to @events' do
    #     assigns(:events).should == fake_all_events
    #   end

    #   it 'should have a "response" json node contain an array of events' do
    #     fake_all_events.each_with_index do |event, index|
    #       ['id', 'name'].each do |field|
    #         @parsed_response[index][field].should == event.send(field)
    #       end
    #       @parsed_response[index]['image'].should == event.image.url
    #     end
    #   end
    # end
  end

  describe 'GET show' do
    let!(:event) { create(:event) }

    before(:each) do
      Event.should_receive(:find).with(event.id.to_s).and_return(event)
      get :show, id: event.id, format: :json
      @parsed_response = JSON.parse(response.body)['response']
    end

    it 'should respond with 200' do
      response.status.should == 200
    end

    it 'should assign the appopriate Event object to @event' do
      assigns(:event).should == event 
    end

    context 'response object' do
      it 'should have proper fields' do
        @parsed_response['id'].should == event.id
        @parsed_response['name'].should == event.name
        @parsed_response['image'].should == event.image.url
      end
    end
  end
end
