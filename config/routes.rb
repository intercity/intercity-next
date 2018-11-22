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
  get "two_factor" => "two_factor_auths#new", as: "two_factor"
  post "two_factor" => "two_factor_auths#create"
  delete "logout" => "sessions#destroy", as: "logout"

  resources :user_activation, only: [:edit, :update]
  resources :users, only: [:index, :create, :destroy] do
    collection do
      resource :two_step_verification, only: [:new, :create, :show, :destroy], module: "users"
    end
    post :resend_activation_mail, on: :member
  end
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :servers, only: [:create, :show, :destroy] do
    get :test_ssh, on: :member
    get :check_installation, on: :member
    get :updating, on: :member
    get :manual_update, on: :member
    post :start_installation, on: :member
    post :start_update, on: :member
    resource :health_check, only: [:create]
    resource :swap, only: [:show, :create, :destroy]
    resources :apps, only: [:index, :new, :create, :destroy, :show] do
      scope module: :apps do
        resources :restarts, only: :create
        resource :letsencrypt, controller: "letsencrypt"
      end
      resources :services, controller: "app_services", only: :index do
        post :create, on: :member
        get :status, on: :member
      end
      resources :env_vars, only: [:index, :create, :destroy]
      resources :domains, only: [:index, :create, :destroy]
      resources :backups, only: [:index, :create] do
        post :enable, on: :collection
        get :status, on: :member
      end
      resource :certificate, only: [:show, :create, :destroy]
    end
    resources :services, only: [:index] do
      post :create, on: :member
      get :status, on: :member
    end
    resources :deploy_keys, only: [:index, :new, :create, :destroy]
  end

  resource :settings, only: [:edit, :update] do
    root to: "settings#edit"
  end

  # Help
  get 'help'                  => 'help#index'
  get 'help/:category/:file'  => 'help#show', as: :help_page, constraints: { category: /.*/, file: /[^\/\.]+/ }

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
