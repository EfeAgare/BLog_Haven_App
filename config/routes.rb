Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  root 'welcome#index'
  get  '/help' => 'welcome#help'
  get  '/signup', to: 'users#new'
  resources :articles
end
 