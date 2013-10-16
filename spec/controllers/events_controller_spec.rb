require 'spec_helper'

describe EventsController do
  describe 'GET index' do
    it 'should respond with 200' do
      get :index
      response.status.should == 200
    end

    it 'should assign all events to @events' do
      event_one = create(:event)
      event_two = create(:event)
      all_events = [event_one, event_two]
      Event.should_receive(:all).and_return(all_events)
      get :index
      assigns(:events).should == all_events
    end
  end

  describe 'GET show' do
    let!(:event) { create(:event) }

    it 'should respond with 200' do
      get :show, id: event
      response.status.should == 200
    end

    it 'should assign the appropriate Event object to @event' do
      Event.should_receive(:find).with(event.id.to_s).and_return(event)
      get :show, id: event
      assigns(:event).should == event
    end
  end

  describe 'GET new' do
    it 'should respond with 200' do
      get :new
      response.status.should == 200
    end

    it 'should assign a new Event object to @event' do
      event = build(:event)
      Event.should_receive(:new).and_return(event)
      get :new
      assigns(:event).should == event
    end
  end

  describe 'GET edit' do
    it 'should respond with 200' do
      event = create(:event)
      get :edit, id: event
      response.status.should == 200
    end

    it 'should assign a new Event object to @event' do
      event = create(:event)
      Event.should_receive(:find).with(event.id.to_s).and_return(event)
      get :edit, id: event
      assigns(:event).should == event
    end
  end

  describe 'POST create' do
    context 'when successful' do
      let!(:event) { build(:event) }

      let!(:valid_event_attributes) do 
        { 'name' => event.name }
      end

      before(:each) do
        Event.should_receive(:new).with(valid_event_attributes).and_return(event)
        post :create, event: valid_event_attributes
      end

      it 'should respond with 302' do
        response.status.should == 302
      end

      it 'should redirect to the @event' do
        response.should redirect_to(event)
      end

      it 'should assign the proper Event object to @event' do
        assigns(:event).should == event
      end

      it 'should set an appropriate notice' do
        controller.flash[:notice].should == 'Event was successfully created.'
      end
    end

    context 'when unsuccessful' do
      let!(:event) { build(:event, name: nil) }

      let(:invalid_event_attributes) do
        { 'name' => nil }
      end

      before(:each) do
        Event.should_receive(:new).with(invalid_event_attributes).and_return(event)
        post :create, event: invalid_event_attributes
      end

      it 'should respond with 200' do
        response.status.should == 200
      end

      it 'should render the "new" template' do
        response.should render_template('new')
      end

      it 'should assign the proper Event object to @event' do
        assigns(:event).should == event
      end
    end
  end

  describe 'PUT update' do
    context 'when successful' do
      let!(:event) { create(:event) }
      let!(:valid_attributes) do
        { 'name' => "#{event.name} Changed" }
      end

      before(:each) do
        Event.should_receive(:find).with(event.id.to_s).and_return(event)
        put :update, id: event, event: valid_attributes
      end

      it 'should assign the proper Event object to @event' do
        assigns(:event).should == event
      end

      it 'should respond with 302' do
        response.status.should == 302
      end

      it 'should set the appropriate notice' do
        controller.flash[:notice].should == 'Event was successfully updated.'
      end

      it 'should redirect to the @event path' do
        response.should redirect_to(event_path(event)) 
      end
    end

    context 'when not successful' do
      let!(:event) { create(:event) }
      let!(:invalid_attributes) do
        { 'name' => nil }
      end

      before(:each) do
        Event.should_receive(:find).with(event.id.to_s).and_return(event)
        put :update, id: event, event: invalid_attributes
      end

      it 'should assign the proper Event object to @event' do
        assigns(:event).should == event
      end

      it 'should respond with 200' do
        response.status.should == 200
      end

      it 'should render "edit" template' do
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:event) { create(:event) }

    before(:each) do
      delete :destroy, id: event
    end

    it 'should respond with 302' do
      response.status.should == 302
    end

    it 'should redirect to events_url' do
      response.should redirect_to(events_url)
    end

    it 'should assign the appropriate Event object to @event' do
      assigns(:event).should == event
    end

    it 'should destroy the record' do
      Event.exists?(event).should be_false
    end
  end
end
