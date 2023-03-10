Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #VERB '/path', to: 'controller#action'

  # get '/users', to: 'users#index'
  # post '/users', to: 'users#create'
  # get '/users/:id', to: 'users#show', as: 'user'
  # patch '/users/:id', to: 'users#update'
  # put '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'
  
  
  resources :users, except: [:new, :edit] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
  end
  resources :artworks, except: [:new, :edit] do
    resources :comments, only: [:index]
  end

  resources :artwork_shares, only: [:create, :destroy]
  
  resources :comments, only: [:create, :destroy, :index]
  
end
