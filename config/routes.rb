Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: 'welcome#index'

  get '/register', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'

  get '/users/:id/discover', to: 'discover#index'

  get '/users/:user_id/movies/:movie_id', to: 'movies#show'

end
