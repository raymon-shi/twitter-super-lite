Rails.application.routes.draw do
  resources :articles, :only => [:index]
  resources :feeds, :only => [:index]
  resources :tweets, :except => [:index, :update]
  resources :interactions
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/users/:id/following', to: "users#following", as: "following_user"
  post '/users/:id/unfollowing', to: "users#unfollowing", as: "unfollowing_user"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/feed', to: 'feeds#new'

  root :to => redirect('/login')

end
