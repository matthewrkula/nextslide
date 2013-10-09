FactoryGirl.define do
  factory :slideshow do
    sequence(:slide_num) {|n| n }
    url { fixture_file_upload("#{Rails.root}/spec/fixtures/files/example.ppt", 'application/vnd.ms-powerpoint') }
    # url { fixture_file_upload("#{Rails.root}/spec/fixtures/files/example.pptx", 
    #                           'application/vnd.openxmlformats-officedocument.presentationml.presentation') }
    sequence(:name) {|n| "name#{n}" }
    association :event
  end
end
