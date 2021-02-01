Rails.application.routes.draw do
  resources :todos
  post '/refresh', to: 'refresh#create'
  post '/signin', to: 'signin#create'
  post '/signup', to: 'signup#create'
  delete '/signin', to: 'signin#destroy'
  get '/me', to: 'users#me'

  namespace :admin do
    resources :users, only: %i[index show update] do
      resources :todos, only: [:index], controller: 'users/todos'
    end
  end

  resources :password_resets, only: [:create] do
    collection do
      get ':token', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end
end
