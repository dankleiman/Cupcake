Rails.application.routes.draw do
  resources :products, only: [:index, :new, :create]

  root "products#index"

end
