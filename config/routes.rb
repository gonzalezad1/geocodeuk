Rails.application.routes.draw do
  resources :offices

  root to: "offices#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
