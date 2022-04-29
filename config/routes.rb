Rails.application.routes.draw do
  get "/signup", to: "users#signup"
  get "/login", to: "users#new"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  # resources :users, except: [:signup]
  resources :users, only: :signup do
    collection do
      get 'confirm'
    end
  end


  resources :password_reset, only: [:create] do
    collection do
      get 'edit', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end

  resources :post
  root to: "post#index"
end
