DepaulMitHacks::Application.routes.draw do
  root to: 'Overviews#index'
  get 'overviews/trigger' => 'overviews#trigger'
  resources :overviews
end
