Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'about',to: "about#index",as: :about
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "session#new"
  get "home",to: "main#index"

  get "sign_up",to: "registrations#new"
  post "sign_up",to: "registrations#create"

  delete "logout",to: "session#destroy"

  get "log_in",to: "session#new"
  post "log_in",to: "session#create"

  get "passwords",to: "passwords#edit", as: :edit_password
  patch "passwords",to: "passwords#update"


end
