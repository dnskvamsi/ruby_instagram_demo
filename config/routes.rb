Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
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

  get "password/reset",to: "password_reset#new"
  post "password/reset",to: "password_reset#create"

  get "password/reset/edit",to: "password_reset#edit"
  patch "password/reset/edit",to: "password_reset#update"

  get "explore",to: "main#explore"
  get "profile/:id",to: "main#profile",as: :profile

  post "search",to: "main#search"

  get "post",to: "posts#new"
  post "post",to: "posts#create"
  get "show_post/:id",to: "posts#show",as: :show
  delete "delete_post/:id",to: "posts#destroy",as: :delete_post

  post "comment/:id",to: "comments#create",as: :comment

  post "follow/:id",to: "relationships#create",as: :follow
  delete "unfollow/:id",to: "relationships#destroy",as: :unfollow



end
