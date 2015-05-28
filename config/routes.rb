Rails.application.routes.draw do
  root 'static_pages#home'

  get 'register' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      get :follows, :followers
    end
  end
  resources :chirps, only: [:create, :destroy]
end
