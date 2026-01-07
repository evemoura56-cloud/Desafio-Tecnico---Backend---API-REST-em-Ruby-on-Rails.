require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products

  # Carrinho
  get '/cart', to: 'carts#show'
  post '/cart', to: 'carts#create'
  post '/cart/add_item', to: 'carts#add_item'
  post '/cart/add_items', to: 'carts#add_items'
  delete '/cart/:product_id', to: 'carts#destroy_item'

  get "up" => "rails/health#show", as: :rails_health_check
  root "rails/health#show"
end
