Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  constraints subdomain: /^[a-z0-9-]+$/ do
    get "/", to: "public_sites#show"
  end
  get "up" => "rails/health#show", as: :rails_health_check

  resources :sites

  root "pages#home"
  get "dashboard/:id", to: "pages#dashboard", as: :dashboard
end
