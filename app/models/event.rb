class Event < ActiveRecord::Base
  attr_accessible :image, :name
  has_many :slideshows
  validates :name, :image, presence: true
end
