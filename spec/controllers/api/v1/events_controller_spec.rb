require 'spec_helper'

describe Api::V1::EventsController do
  render_views

  it 'should inherit from BaseController' do
    subject.class.ancestors.should include(Api::V1::BaseController)
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

    context 'before stubbing out events for easier testing' do
      it 'should respond with 200' do
        response.status.should == 200
      end

      it 'should only return the events that belong to the user' do
        get :index, format: :json
        assigned_events = assigns(:events)
        assigned_events.length.should == 2
        assigned_events.each {|event| events.should include(event) }
      end
    end

    context 'after stubbing out for easier testing' do
      before(:each) do
        controller.send(:current_user).should_receive(:events).and_return(events)
        get :index, format: :json
        @parsed_json = JSON.parse(response.body)
      end

      it 'should assign current_user#events to @events' do
        assigns(:events).should == events
      end

      it 'should respond only with proprietary events' do
        @parsed_json['response'].each_with_index do |event, index|
          [ 'id', 'name' ].each do |field|
            event[field].should == events[index][field]
          end
          event['image'].should == events[index].image.url
        end
      end
    end
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
