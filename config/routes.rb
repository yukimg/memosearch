Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts
  
  # get 'users/new'
  # get 'users/create'
    get 'signup', to: 'users#new'
    resources :users, only: [:new, :create]
end
