Rails.application.routes.draw do
  get "/login", to: "logins#new"
  get "login/create", to: "logins#create", as: :create_login
  get "/dashboard", to: "users#show", as: :dashboard

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"
end
