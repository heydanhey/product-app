Rails.application.routes.draw do
  get '/all' => 'products#show_all'
  get '/' => 'products#home'
  get '/big_banana' => 'products#show_one'
end
