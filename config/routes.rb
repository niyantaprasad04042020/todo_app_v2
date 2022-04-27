Rails.application.routes.draw do
  get 'post/index'
  get "/signup", to: "users#signup"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  root to: "post#index"
  resources :users, except: [:signup]
  # resources :users, only: :signup do
  #   collection do
  #     get 'confirm'
  #   end
  # end

  resources :password_reset, only: [:create] do
    collection do
      get 'edit', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end
end
