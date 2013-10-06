json.response do
  json.id @slideshow.id
  json.slide_num @slideshow.slide_num
  json.url @slideshow.url
  json.name @slideshow.name
  json.event_id @slideshow.event_id
  first_slide = 1
  if @slideshow.slide_num > 0
    json.first_image_url "https://docs.google.com/viewer?url=#{@slideshow.url}&a=bi&pagenumber=#{first_slide}&w=300"
  else
    json.first_image_url ""
  end
  json.slides @slideshow.slides do |slide|
    json.id slide.id
    json.note slide.note
    json.slide_number slide.slide_number
  end
end
