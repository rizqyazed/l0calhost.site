Rails.application.routes.draw do
  get "dashboards/index"
  constraints subdomain: /^[a-z0-9-]+$/ do
    get "/", to: "public_sites#show"
  end
  get "up" => "rails/health#show", as: :rails_health_check

  resources :sites
  resources :dashboards

  root "pages#home"
end
