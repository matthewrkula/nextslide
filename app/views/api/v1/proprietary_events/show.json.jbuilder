json.response do
  json.id @proprietary_event.id
  json.name @proprietary_event.name
  json.image @proprietary_event.image.url
end
