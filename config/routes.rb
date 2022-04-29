Rails.application.routes.draw do
  get "/signup", to: "users#signup"
  get "/login", to: "users#new"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/users/confirm", to: "users#confirm"
  resources :users, except: [:signup]

  resources :password_reset, only: [:create] do
    collection do
      get 'edit', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end

  resources :post
  root to: "post#index"
end
