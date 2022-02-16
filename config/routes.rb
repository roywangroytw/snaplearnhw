Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "welcomes#index"

  get 'sign_up', to: "users#signup"
  post 'registering', to: "users#registering"
  get 'login', to: "users#login"
  post 'verifying', to: "users#verifying"
  delete 'logout', to: "users#logout"

  resources :courses do
    collection do
      get 'admin/management', to: "courses#manage"
      get :mycourses, to: "courses#mycourses"
    end
    member do
      get :purchase, to: "orders#purchase"
      get :ordersuccess, to: "orders#ordersuccess"
    end
  end

  mount ApiRoot => ApiRoot::PREFIX

  match '*path' => redirect('/'), :via => :all

end
