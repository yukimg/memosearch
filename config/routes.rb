Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
    get 'signup', to: 'users#new'
    resources :users, only: [:new, :create]
end
