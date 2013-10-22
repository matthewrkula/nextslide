json.response @proprietary_events do |proprietary_event|
  json.id proprietary_event.id
  json.name proprietary_event.name
  json.image proprietary_event.image.url
end
