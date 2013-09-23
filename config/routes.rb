Socialex::Application.routes.draw do
  get "static_pages/index"

  resources :users

root to: "static_pages#index"

end
