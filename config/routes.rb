Rails.application.routes.draw do
  post "/signup", to: "users#signup"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  resources :users, only: :signup do
    collection do
      get 'confirm'
    end
  end

  resources :password_resets, only: [:create] do
    collection do
      get 'edit', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end
end
