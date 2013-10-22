class Event < ActiveRecord::Base
  attr_accessible :image, :name
  belongs_to :user
  has_many :slideshows
  validates :name, :user_id, presence: true
  mount_uploader :image, EventImageUploader
end
