require 'spec_helper'

describe Slideshow do

  # TODO
  # slide_num field not being validated, yet it is required for a slideshow to function properly.
  # what do we do in this case? We cannot require it until we save the slideshow object...
  # this would be possible using some ajax uploader form.
  # we need to upload the file first, look at how many pages are there using Shabbir's api, 
  # and then finally...set the slide_num field

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

  context '#first_slide_page_number' do
    it 'should return 1' do
      slideshow = create(:slideshow)
      slideshow.first_slide_page_number.should == 1
    end
  end

  context '#first_slide_image_url' do
    context 'when slide_num > 0' do
      it 'should return "https://docs.google.com/viewer?url=#{url}&a=bi&pagenumber=#{first_slide_page_number}&w=300"' do
        slideshow = create(:slideshow)
        value_above_zero = 1
        slideshow.should_receive(:slide_num).and_return(value_above_zero)
        slideshow.should_receive(:url).and_return('fake_url')
        slideshow.should_receive(:first_slide_page_number).and_return('fake_first_slide_page_number')
        slideshow.first_slide_image_url.should == 
          "https://docs.google.com/viewer?url=fake_url&a=bi&pagenumber=fake_first_slide_page_number&w=300"
      end
    end

    context 'when slide_num <= 0' do
      it 'should return an empty string return "" when slide_num == 0' do
        slideshow = create(:slideshow)
        zero = 0
        slideshow.should_receive(:slide_num).and_return(zero)
        slideshow.first_slide_image_url.should == ''
      end

      it 'should return an empty string return "" when slide_num == -1' do
        slideshow = create(:slideshow)
        value_below_zero = -1
        slideshow.should_receive(:slide_num).and_return(value_below_zero)
        slideshow.first_slide_image_url.should == ''
      end
    end
  end
  
end
