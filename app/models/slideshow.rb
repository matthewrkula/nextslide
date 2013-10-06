class Slideshow < ActiveRecord::Base
  attr_accessible :slide_num, :url, :name, :event_id
  belongs_to :event
  has_many :slides
  validates :name, :url, :event_id, presence: true
  # :slide_num
  mount_uploader :url, SlideshowUploader
end
