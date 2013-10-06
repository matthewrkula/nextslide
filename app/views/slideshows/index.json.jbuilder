json.response @slideshows do |slideshow|
  json.id slideshow.id
  json.slide_num slideshow.slide_num
  json.url slideshow.url
end
