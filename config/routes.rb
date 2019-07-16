# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/password_resets/new'
  get '/password_resets/edit'
  get '/password_reset/new'
  get '/password_reset/edit'
  get '/sessions/new'
  get '/users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  get  '/help' => 'welcome#help'
  get  '/signup', to: 'users#new'

  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  patch '/users/update', to: 'users#update_user'

  patch '/user/:id/upload', to: "users#uploadImage", as: "upload_picture"

  resources :articles do
    resources :comments
    
  end
  get '/users/articles/:user_id', to: "articles#user_articles", as: 'user_articles'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  post '/user/article/like/:article_id/:user_id', to: "like_and_dislikes#like", as: 'like'
  post '/user/article/dislike/:article_id/:user_id', to: "like_and_dislikes#dislike", as: 'dislike'
  resources :password_resets,     only: %i[new create edit update]
  resources :microposts
  resources :relationships,       only: [:create, :destroy]
  
  post '/user/microposts', to: 'microposts#create_micropost'
  get '/users/microposts/:id', to: 'microposts#show_micropost', as: 'user_micropost'
  delete '/user/microposts/:id', to: 'microposts#destroy'

  
end
