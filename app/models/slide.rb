class Slide < ActiveRecord::Base
  attr_accessible :note, :slide_number, :slideshow_id
  validates :slide_number, :slideshow_id, presence: true
  belongs_to :slideshow
end

