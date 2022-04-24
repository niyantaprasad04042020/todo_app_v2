Rails.application.routes.draw do
  post "/signup", to: "users#signup"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  resources :users, only: :signup do
    collection do
      get 'confirm'
    end
  end
end
