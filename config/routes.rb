Rails.application.routes.draw do
  resources :posts
  get '/posts/:id/changes', to: 'posts#changes'
  get '/posts/:id/votes', to: 'posts#votes'
  get '/posts/:id/like', to: 'posts#like'
  get '/posts/:id/dislike', to: 'posts#dislike'
  devise_for :users, controllers: {
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    unlocks: 'user/unlocks'
  }
  get '/users/edit_info', to: 'users#edit_info'
  get '/users/:id', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
