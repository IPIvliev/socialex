Socialex::Application.routes.draw do

  get "/admin/statistics.html", :to => "admin#statistics"

  resources :posts


# Статические страницы
  get "static_pages/index"
  get "stocks.html", :to => "users#stocks"


  resources :users
  resources :orders

# Действия
  get "pay.html", :to => "users#pay"
  
# Оплата
  scope 'robokassa' do
    match 'paid'    => 'robokassa#paid',    :as => :robokassa_paid # to handle Robokassa push request

    match 'success' => 'robokassa#success', :as => :robokassa_success # to handle Robokassa success redirect
    match 'fail'    => 'robokassa#fail',    :as => :robokassa_fail # to handle Robokassa fail redirect
  end


# Поиск
match 'users/search', to: 'users#search'

# Аутентификация
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'

# Корневая страница
root to: "static_pages#index"

end
