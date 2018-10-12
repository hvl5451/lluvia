Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  
  resources :users, only: [:create, :edit, :update]

  match 'users/callback', :to => "users#callback", :via => "get", as: "callback"

  get '/auth/spotify/callback', to: "users#callback"

  match 'users/home', :to => "users#home", :via => "get", as: "home"

  match 'users/generate_playlist', :to => "users#generate_playlist", :via => "get", as: "generate_playlist"

  match 'users/show_playlist', :to => "users#show_playlist", :via => "get", as: "show_playlist"

end
