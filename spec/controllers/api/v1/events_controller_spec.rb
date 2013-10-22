require 'spec_helper'

describe Api::V1::EventsController do
  render_views

  describe 'GET index' do
    let!(:event_one) { create(:event) }
    let!(:event_two) { create(:event) }
    let!(:fake_all_events) { [event_one, event_two] }

    before(:each) do
      Event.should_receive(:all).and_return(fake_all_events)
      get :index, format: :json
      @parsed_response = JSON.parse(response.body)['response']
    end

    it 'should respond with 200' do
      response.status.should == 200 
    end

    it 'should assign all Event objects to @events' do
      assigns(:events).should == fake_all_events
    end

    it 'should have a "response" json node contain an array of events' do
      fake_all_events.each_with_index do |event, index|
        ['id', 'name'].each do |field|
          @parsed_response[index][field].should == event.send(field)
        end
        @parsed_response[index]['image'].should == event.image.url
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
