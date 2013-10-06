DepaulMitHacks::Application.routes.draw do
  root to: 'Overviews#index'
  get 'overviews/trigger' => 'overviews#trigger'
  get 'slideshow/:id/forward' => 'slideshow#forward'
  get 'slideshow/:id/backward' => 'slideshow#backward'
  get 'slideshows' => 'slideshow#index'
  resources :overviews
  match '/upload', to: 'upload#upload'
  match '/submit', to: 'upload#submit', via: 'post'
  match '/slideshow/:id', to: 'slideshow#show'
end
