Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: 'welcome#index'

  get '/register', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'

  get '/users/:id/discover', to: 'discover#index'

  get '/users/:user_id/movies/:movie_id', to: 'movies#show'
  get '/users/:user_id/movies', to: 'movies#index'

  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
