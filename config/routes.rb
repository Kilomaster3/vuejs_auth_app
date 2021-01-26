Rails.application.routes.draw do
  resources :todos
  post '/refresh', to: 'refresh#create'
  post '/signin', to: 'signin#create'
  post '/signup', to: 'signup#create'
  delete '/signin', to: 'signin#destroy'
  get '/me', to: 'users#me'

  namespace :admin do
    resources :users, only: [:index] do
      resources :todos, only: [:index], controller: 'users/todos'
    end
  end
end
