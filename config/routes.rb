Rails.application.routes.draw do
  resources :posts
  get '/posts/:id/changes', to: 'posts#changes'
  get '/posts/:id/votes', to: 'posts#votes'
  devise_for :users, controllers: {
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    unlocks: 'user/unlocks'
  }
  get '/users/edit_info', to: 'users#edit_info'
  patch '/users/update_info', to: 'users#update_info'
  get '/users/:id', to: 'users#show'
  resources :comments
  get '/comments/:commentable_type/:commentable_id/new', to: 'comments#new'
  get '/comments/:commentable_type/:commentable_id', to: 'comments#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
