Rails.application.routes.draw do
  resources :todos
  post '/refresh', to: 'refresh#create'
  post '/signin', to: 'signin#create'
  post '/signup', to: 'signup#create'
  delete '/signin', to: 'signin#destroy'
end
