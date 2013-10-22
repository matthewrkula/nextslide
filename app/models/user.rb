class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :password, length: { minimum: 8 }, :if => :validate_password?
  validates :password, confirmation: false, :if => :dont_validate_password?

  def validate_password?
    new_record? || password.present? || password_confirmation.present?
  end

  def dont_validate_password?
    !validate_password?
  end
end
