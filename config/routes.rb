Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"
  get '/about' => 'products#about'
  get '/products' => 'products#index'
  get '/products/new' => 'products#new'
  post '/products' => 'products#create'
  get '/products/:id' => 'products#show'
  get 'products/:id/edit' => 'products#edit'
  patch 'products/:id' => 'products#update'
  delete 'products/:id' => 'products#destroy'
  get '/test' => 'products#home'
  post "/search" => 'products#search'

  get '/suppliers' => 'suppliers#index'
  get '/suppliers/:id' => 'suppliers#show'

  get '/images/new' => 'images#new'
  post '/images' => 'images#create'

  post '/orders' => 'orders#create'
  get '/orders' => 'orders#index'
  get '/orders/:id' => 'orders#show'

  post '/cart' => 'carted_products#create' 
  get '/cart' => 'carted_products#index'
  delete 'cart/:id' => 'carted_products#destroy'
   
end
