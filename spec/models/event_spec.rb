require 'spec_helper'

describe Event do
  [ :id, :name, :image, :user_id, :created_at, :updated_at ].each do |field|
    it { should respond_to field }
  end

  [ :image, :name ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :id, :user_id, :created_at, :updated_at ].each do |field|
    it { should_not allow_mass_assignment_of field }
  end

  it { should belong_to :user }
  it { should have_many(:event_memberships) }
  it { should have_many(:users).through(:event_memberships) }
  it { should have_many :slideshows }

  [ :name, :user_id ].each do |field|
    it { should validate_presence_of field }
  end

  context 'image field' do
    it 'should mount the image uploader' do
      event = create(:event)
      event.image.class.should == EventImageUploader
    end
  end

  context 'after create' do
    it 'should call #create_event_membership_for_user' do
      event = build(:event)
      event.should_receive(:create_event_membership_for_its_own_user).once.and_return(true)
      event.save
    end
  end

  context '#create_event_membership_for_its_own_user' do
    it 'should call #create_event_membership_for(user) with its own user' do
      user = create(:user)
      event = build(:event, user: user)

      # to avoid duplicate error 
      event.stub(:create_event_membership_for_its_own_user).and_return(true)
      event.save

      event.unstub(:create_event_membership_for_its_own_user)
      event.create_event_membership_for_its_own_user
      EventMembership.last.should == 
        EventMembership.where(user_id: user.id, event_id: event.id).first
    end
  end
  
  context '#create_event_membership_for(user)' do
    it 'should create a new EventMembership object in the database' do
      another_user = create(:user)
      event = create(:event)
      event.create_event_membership_for_user(another_user)
      EventMembership.where(user_id: another_user.id, event_id: event.id)
    end
  end
end
