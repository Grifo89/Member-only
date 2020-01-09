Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'
  # get '/posts', to: 'posts#new'
  # post '/posts', to: 'posts#create'

  get '/index', to: 'posts#index'
  resources :users
  resources :posts
end
