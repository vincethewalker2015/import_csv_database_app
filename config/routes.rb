Rails.application.routes.draw do
  resources :doctors do
  collection { post :import }
end
  root to: "doctors#index"
  #get 'doctors/import'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
