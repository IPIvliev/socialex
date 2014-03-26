Socialex::Application.routes.draw do

# Статические страницы
  get "static_pages/index"
  get "stocks.html", :to => "users#stocks"

  resources :users
  resources :orders

# Действия

# Поиск
match 'users/search', to: 'users#search'

# Аутентификация
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'

# Корневая страница
root to: "static_pages#index"

end
