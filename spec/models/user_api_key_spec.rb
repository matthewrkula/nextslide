require 'spec_helper'

describe UserApiKey do
  [ :access_token, :user_id ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :id, :created_at, :updated_at ].each do |field|
    it { should_not allow_mass_assignment_of field }
  end

  it { should belong_to :user }

  it { should validate_presence_of :user_id }

  context 'before_create' do
    it 'should call #generate_access_token once' do
      user_api_key = build(:user_api_key)
      user_api_key.should_receive(:generate_access_token).once
      user_api_key.save
    end
  end

  context '#generate_access_token' do
    it 'should be tested' do
      user_api_key = create(:user_api_key)
      initial_access_token = user_api_key.access_token
      user_api_key.send(:generate_access_token)
      user_api_key.access_token.should_not == initial_access_token.should
    end
  end
end

