Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: %i[create show]
  root to: 'rooms#index'
end
