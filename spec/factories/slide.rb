FactoryGirl.define do
  factory :slide do
    sequence(:name) {|n| "name#{n}" } 
    sequence(:note) {|n| "note#{n}" }
    sequence(:slide_number) {|n| n }
    url { fixture_file_upload("#{Rails.root}/spec/fixtures/files/example.ppt", 'application/vnd.ms-powerpoint') }
    # url { fixture_file_upload("#{Rails.root}/spec/fixtures/files/example.pptx", 
    #                           'application/vnd.openxmlformats-officedocument.presentationml.presentation') }
    association :slideshow
  end
end
