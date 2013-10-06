class Slideshow < ActiveRecord::Base
  attr_accessible :slide_num, :url, :name, :event_id
  belongs_to :event
  validates :name, :url, :slide_num, :event_id, presence: true
end
