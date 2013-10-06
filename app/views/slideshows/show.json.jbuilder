json.response do
  json.id @slideshow.id
  json.slide_num @slideshow.slide_num
  json.url @slideshow.url
  json.name @slideshow.name
  json.event_id @slideshow.event_id
end
