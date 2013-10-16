require 'spec_helper'

describe OverviewsController do

  describe 'GET index' do
    it 'should respond with 200' do
      get :index
      response.status.should == 200
    end
  end
end
