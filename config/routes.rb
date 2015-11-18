Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: "servers#index"

  resources :servers, only: [:new, :create] do
    get :ssh_key, on: :member
    post :test, on: :member
    resources :apps, only: [:index, :new, :create]
  end
end
