Rails.application.routes.draw do
  resources :customers
  resources :movies

  get '/zomg', to: 'movies#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
