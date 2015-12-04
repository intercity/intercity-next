Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: "servers#index"

  resources :servers, only: [:new, :create, :show, :destroy] do
    get :ssh_key, on: :member
    get :test, on: :member
    resources :apps, only: [:index, :new, :create, :destroy, :show] do
      resources :services, controller: "app_services", only: :index do
        post :create, on: :member
      end
    end
    resources :services, only: [:index] do
      post :create, on: :member
      get :status, on: :member
    end
  end
end
