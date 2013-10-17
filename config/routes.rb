Socialex::Application.routes.draw do
  get "static_pages/index"

  resources :users
  resources :stocks
  
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'

root to: "static_pages#index"

end
