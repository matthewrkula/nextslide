require 'spec_helper'

describe Api::V1::UserApiKeysController do
  render_views

  describe 'POST create' do
    context 'when successful' do
      let!(:user) { create(:user) }
      let!(:user_api_key) { build(:user_api_key) }

      let!(:params_hash) do
        { 
          user_api_key: { email: user.email }
        }
      end

      let!(:user_api_key_params) do 
        { email: user.email }
      end

      before(:each) do
        User.should_receive(:where).with(email: params_hash[:user_api_key][:email]).and_return([user])
        UserApiKey.should_receive(:new).with({user_id: user.id}).and_return(user_api_key)
        post :create, user_api_key: user_api_key_params, format: :json
        @parsed_response = JSON.parse(response.body)['response']
      end

      it "should assign @user_api_key to the User object's new key" do
        assigns(:user_api_key).should == user_api_key
      end

      it 'should respond with 201' do
        response.status.should == 201
      end

      it 'should set @saved_successfully to true' do
        assigns(:saved_successfully).should == true
      end

      it 'should set "Authorization-Token" header using the access_token from @user_api_key' do
        response.headers['Authorization-Token'].should == user_api_key.access_token
      end

      context '"response" json object' do
        it 'should not be nil' do
          @parsed_response.should_not be_nil
        end

        it 'should contain an "access_token" node' do
          @parsed_response['access_token'].should == user_api_key.access_token
        end
      end
    end

    context 'when not successful' do
      let!(:user) { create(:user) }
      let!(:user_api_key) { build(:user_api_key) }

      let!(:params_hash) do
        { 
          user_api_key: { email: user.email }
        }
      end

      let!(:user_api_key_params) do 
        { email: user.email }
      end

      before(:each) do
        user_api_key.should_receive(:save).and_return(false)
        User.should_receive(:where).with(email: params_hash[:user_api_key][:email]).and_return([user])
        UserApiKey.should_receive(:new).with({user_id: user.id}).and_return(user_api_key)
        post :create, user_api_key: user_api_key_params, format: :json
        @parsed_json = JSON.parse(response.body)
      end

      it "should assign @user_api_key to the User object's new key" do
        assigns(:user_api_key).should == user_api_key
      end

      it 'should respond with 422' do
        response.status.should == 422
      end

      it 'should set @saved_successfully to false' do
        assigns(:saved_successfully).should == false
      end

      it 'should not set "Authorization-Token" header' do
        response.headers['Authorization-Token'].should be_nil
      end

      context '"errors" json object' do
        it 'should not be nil' do
          @parsed_json['errors'].should_not be_nil
        end

        it 'should equal to @user_api_key.errors' do
          @parsed_json['errors'].should == user_api_key.errors.to_hash
        end
      end

      context '"response" json object' do
        it 'should be nil' do
          @parsed_json['response'].should be_nil
        end
      end
    end
  end
end
