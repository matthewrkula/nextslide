class Event < ActiveRecord::Base
  attr_accessible :image, :name
  belongs_to :user
  has_many :slideshows
  validates :name, :user_id, presence: true
  mount_uploader :image, EventImageUploader
  has_many :event_memberships
  has_many :users, through: :event_memberships
  after_create :create_event_membership_for_its_own_user

  def create_event_membership_for_user(user_to_create_membership_for)
    event_membership = EventMembership.new
    event_membership.user = user_to_create_membership_for
    event_membership.event = self
    return event_membership.save
  end

  def create_event_membership_for_its_own_user
    create_event_membership_for_user(user)
  end
end
