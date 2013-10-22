json.response do
  json.id @event.id
  json.name @event.name
  json.image @event.image.url
end
