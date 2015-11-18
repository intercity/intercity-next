Rails.application.routes.draw do
  root to: "servers#index"

  resources :servers, only: [:new, :create]
end
