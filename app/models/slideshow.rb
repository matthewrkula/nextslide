class Slideshow < ActiveRecord::Base
  attr_accessible :slide_num, :url, :name, :event_id
  belongs_to :event
  has_many :slides
  validates :name, :url, :event_id, presence: true
  # TODO
  # slide_num field not being validated, yet it is required for a slideshow to function properly.
  # what do we do in this case? We cannot require it until we save the slideshow object...
  # this would be possible using some ajax uploader form.
  # we need to upload the file first, look at how many pages are there using Shabbir's api, 
  # and then finally...set the slide_num field
  mount_uploader :url, SlideshowUploader

  def first_slide_page_number
    1
  end

  def first_slide_image_url
    return "https://docs.google.com/viewer?url=#{url}&a=bi&pagenumber=#{first_slide_page_number}&w=300" if slide_num > 0
    return ""
  end
end
