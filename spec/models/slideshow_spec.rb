require 'spec_helper'

describe Slideshow do
  [ :id, :slide_num, :url, :created_at, :updated_at, :event_id, :name ].each do |field|
    it { should respond_to field }
  end

  [ :slide_num, :url, :name, :event_id ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :slide_num, :url, :name, :event_id ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  it { should belong_to :event }

  it { should have_many :slides }

  [ :name, :url, :event_id ].each do |field|
    it { should validate_presence_of field }
  end

  context 'url field' do
    it 'should mount the image uploader' do
      slideshow = create(:slideshow)
      slideshow.url.class.should == SlideshowUploader
    end
  end
end
