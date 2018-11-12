Rails.application.routes.draw do

  resources :leaderboards
  resources :scores
  resources :options
  resources :questions
  get 'player/index'

  get 'admin/index'

  resources :subgenres
  resources :genres
  #get 'admin/index'

  #get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users

  get 'admin' => 'admin#index'
  get 'player' => 'player#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  root 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
