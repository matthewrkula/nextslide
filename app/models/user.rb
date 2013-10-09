class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :password, length: { minimum: 8 }, confirmation: true, :if => :validate_password?
  def validate_password?
    new_record? || password.present? || password_confirmation.present?
  end
end
