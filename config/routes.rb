Rails.application.routes.draw do
	post "/signup", to: "users#signup"
	post "/login", to: "users#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
