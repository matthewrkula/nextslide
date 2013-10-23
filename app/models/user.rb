class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :password, length: { minimum: 8 }, :if => :validate_password?
  validates :password, confirmation: false, :if => :dont_validate_password?
  has_many :event_memberships
  has_many :events, through: :event_memberships
  has_many :proprietary_events, :class_name => 'Event', foreign_key: 'user_id'

  def validate_password?
    new_record? || password.present? || password_confirmation.present?
  end

  def dont_validate_password?
    !validate_password?
  end

  def give_event_access_to_user(event, the_user_to_give_access_to)
    proprietary_events.find(event).
      create_event_membership_for_user(the_user_to_give_access_to)
  end
end
