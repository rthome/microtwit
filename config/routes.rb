Rails.application.routes.draw do
  resources :users

  root to: 'static_pages#home'
  
  match '/register', to: 'users#new', via: 'get'
end
