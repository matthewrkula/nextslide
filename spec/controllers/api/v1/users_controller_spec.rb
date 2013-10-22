require 'spec_helper'

describe Api::V1::UsersController do
  render_views

  describe 'GET show' do
    let!(:user) { create(:user) }

    before(:each) do
      get :show, id: user, format: :json
    end

    it 'should respond with 200' do
      response.status.should == 200
    end

    it 'should assign an appropriate User objec to @user' do
      assigns(:user).should == user
    end

    it 'should set the @user properties inside the response json object' do
      parsed_response = JSON.parse(response.body)['response']
      [ 'id', 'email' ].each do |field|
        parsed_response[field].should == user.send(field)
      end
    end
  end

  describe 'POST create' do
    let!(:user) { build(:user) }

    context 'when successful' do
      let!(:valid_attributes) do
        {
          'email' => user.email,
          'password' => user.password,
          'password_confirmation' => user.password_confirmation
        }
      end

      it 'should respond with 201' do
        post :create, user: valid_attributes, format: :json
        response.status.should == 201
      end

      it 'should set @saved_successfully to true' do
        post :create, user: valid_attributes, format: :json
        assigns(:saved_successfully).should == true
      end

      it 'should assign the new User object to @user' do
        User.should_receive(:new).and_return(user)
        post :create, user: valid_attributes, format: :json
        assigns(:user).should == user
      end

      it 'should create a new User in the database' do
        initial_user_count = User.count
        post :create, user: valid_attributes, format: :json
        new_user_count = User.count
        new_user_count.should == initial_user_count + 1
      end

      it 'should have User object attributes inside response object' do
        User.should_receive(:new).and_return(user)
        post :create, user: valid_attributes, format: :json
        parsed_json = JSON.parse(response.body)['response']
        [ 'id', 'email' ].each do |field|
          parsed_json[field].should == user.send(field)
        end
      end
    end

    context 'when unsuccessful' do
      let!(:user) { build(:user) }

      let!(:invalid_attributes) do
        {
          'email' => user.email,
          'password' => user.password,
          'password_confirmation' => "#{user.password_confirmation}different"
        }
      end

      it 'should respond with 422' do
        post :create, user: invalid_attributes, format: :json
        response.status.should == 422
      end

      it 'should assign @saved_successfully to false' do
        post :create, user: invalid_attributes, format: :json
        assigns(:saved_successfully).should == false
      end

      it 'should assign the new User object to @user' do
        User.should_receive(:new).with(invalid_attributes).and_return(user)
        post :create, user: invalid_attributes, format: :json
        assigns(:user).should == user
      end

      it 'should have "errors" json object' do
        post :create, user: invalid_attributes, format: :json
        parsed_errors = JSON.parse(response.body)['errors']
        parsed_errors.should_not be_nil
        parsed_errors['password'].should == ["doesn't match confirmation"]
      end
    end
  end
end
