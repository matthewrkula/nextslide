FactoryGirl.define do
  factory :user_api_key do
    access_token SecureRandom.hex
    association :user
  end
end
