Rails.application.routes.draw do
  root 'static_pages#home'

  get 'register' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
end
