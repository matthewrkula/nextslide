DepaulMitHacks::Application.routes.draw do
  root to: 'overviews#index'
  get 'slideshow/:id/forward' => 'slideshow#forward'
  get 'slideshow/:id/backward' => 'slideshow#backward'
  resources :overviews
  match '/upload', to: 'upload#upload'
  match '/submit', to: 'upload#submit', via: 'post'
  match '/slideshow/:id', to: 'slideshow#show'
end
