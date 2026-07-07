Rails.application.routes.draw do
  get "pages/home"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :sites

  root "pages#home"
end
