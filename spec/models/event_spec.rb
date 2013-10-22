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
end
