class UserApiKey < ActiveRecord::Base
  attr_accessible :access_token, :user_id
  belongs_to :user
  before_create :generate_access_token
  validates :user_id, presence: true

private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while UserApiKey.exists?(access_token: access_token)
  end
end
