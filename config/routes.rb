require "sidekiq/web"
require 'sidekiq/cron/web'
require "user_constraint"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: UserConstraint.new

  root to: "servers#index"

  get "welcome" => "onboarding#index", as: "welcome"
  post "welcome" => "onboarding#create"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy", as: "logout"

  resources :user_activation, only: [:edit, :update]
  resources :users, only: [:index, :create] do
    post :resend_activation_mail, on: :member
  end

  resources :servers, only: [:new, :create, :show, :destroy] do
    get :test_ssh, on: :member
    get :check_installation, on: :member
    get :updating, on: :member
    get :manual_update, on: :member
    post :start_installation, on: :member
    post :start_update, on: :member
    resource :health_check, only: [:create]
    resources :apps, only: [:index, :new, :create, :destroy, :show] do
      resources :services, controller: "app_services", only: :index do
        post :create, on: :member
      end
      resources :env_vars, only: [:index, :create, :destroy]
      resources :domains, only: [:index, :create, :destroy]
      resources :backups, only: [:index, :create] do
        post :enable, on: :collection
        get :status, on: :member
      end
    end
    resources :services, only: [:index] do
      post :create, on: :member
      get :status, on: :member
    end
    resources :deploy_keys, only: [:index, :new, :create, :destroy]
  end

  # Help
  get 'help'                  => 'help#index'
  get 'help/:category/:file'  => 'help#show', as: :help_page, constraints: { category: /.*/, file: /[^\/\.]+/ }
end
