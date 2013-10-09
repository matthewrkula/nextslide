FactoryGirl.define do
  factory :event do
    sequence(:name) {|n| "name#{n}" } 
    image { fixture_file_upload("#{Rails.root}/spec/fixtures/files/example.jpg", 'image/jpeg') }
  end
end
