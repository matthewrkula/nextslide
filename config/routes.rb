DepaulMitHacks::Application.routes.draw do
  get '/events/:event_id/slideshows/:id/forward' => 'slideshows#forward'
  get '/events/:event_id/slideshows/:id/backward' => 'slideshows#backward'
  resources :events do
    resources :slideshows
  end
  root to: 'events#index'
  resources :overviews
  match '/upload', to: 'upload#upload'
  match '/submit', to: 'upload#submit', via: 'post'
end
