Rails.application.routes.draw do
  require "sidekiq/web"
  require "user_constraint"

  mount Sidekiq::Web => "/sidekiq", constraints: UserConstraint.new

  root to: "servers#index"

  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy", as: "logout"

  resources :servers, only: [:new, :create, :show, :destroy] do
    get :test, on: :member
    resources :apps, only: [:index, :new, :create, :destroy, :show] do
      resources :services, controller: "app_services", only: :index do
        post :create, on: :member
      end
      resources :env_vars, only: [:index, :create, :destroy]
      resources :domains, only: [:index, :create, :destroy]
    end
    resources :services, only: [:index] do
      post :create, on: :member
      get :status, on: :member
    end
    resources :deploy_keys, only: [:index, :new, :create, :destroy]
  end
end
