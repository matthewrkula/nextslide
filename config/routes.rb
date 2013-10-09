DepaulMitHacks::Application.routes.draw do
  get '/events/:event_id/slideshows/:id/forward' => 'slideshows#forward'
  get '/events/:event_id/slideshows/:id/backward' => 'slideshows#backward'
  get '/events/:event_id/slideshows/:id/choose' => 'slideshows#choose'

  get 'dashboard' => 'dashboard#index'

  resources :events do
    resources :slideshows
  end

  resources :slideshows do
    resources :slides, only: [:index, :edit, :update]
  end

  root to: 'events#index'
  resources :overviews
  match '/upload', to: 'upload#upload'
  match '/submit', to: 'upload#submit', via: 'post'
end
