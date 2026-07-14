Rails.application.routes.draw do
  constraints subdomain: /^[a-z0-9-]+$/ do
    get "/", to: "public_sites#show"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resource :sign_up
  resource :session
  resources :passwords, param: :token
  resources :sites do
    member do
      get :export
  end
  end

  root "pages#home"
  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "directory", to: "pages#directory", as: :directory
end
