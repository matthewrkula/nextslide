require 'spec_helper'

describe Event do
  [ :id, :name, :image, :created_at, :updated_at ].each do |field|
    it { should respond_to field }
  end

  [ :image, :name ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :id, :created_at, :updated_at ].each do |field|
    it { should_not allow_mass_assignment_of field }
  end

  it { should have_many :slideshows }

  it { should validate_presence_of :name }

  context 'image field' do
    it 'should mount the image uploader' do
      event = create(:event)
      event.image.class.should == EventImageUploader
    end
  end
end
