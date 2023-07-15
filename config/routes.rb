Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: %i[create show] do
    resources :messages, only: :create
  end

  resources :users, only: :show

  root to: 'rooms#index'
end
