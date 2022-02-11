Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "welcomes#index"

  get 'sign_up', to: "users#signup"
  post 'registering', to: "users#registering"
  get 'login', to: "users#login"
  post 'verifying', to: "users#verifying"
  delete 'logout', to: "users#logout"

end
