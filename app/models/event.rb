class Event < ActiveRecord::Base
  attr_accessible :image, :name
  has_many :slideshows
  validates :name, presence: true
  mount_uploader :image, EventImageUploader
end
