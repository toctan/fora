Fora::Application.routes.draw do
  root 'topics#index'

  delete 'sign_out' => 'sessions#destroy', as: :sign_out

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match 'auth/failure' => 'sessions#failure', via: :get

  get 'go/:key'  => 'nodes#show', as: :node
  get 'new/:key' => 'topics#new', as: :new_topic

  post 'like/:type/:id' => 'likes#create_or_destroy',     as: :like
  post 'bookmark/:id'   => 'bookmarks#create_or_destroy', as: :bookmark
  get  'bookmarks'      => 'bookmarks#index',             as: :bookmarks

  resources :users, only: [:new, :create]

  resources :nodes, only: [:index, :new, :create]

  resources :topics, except: [:edit, :update, :destroy, :new] do
    resources :replies, only: [:create, :index]
  end

  resources :notifications, only: [:index, :destroy] do
    delete 'clear', on: :collection
  end

  namespace :admin do
    resources :nodes,   only: :create
    resources :topics,  only: :destroy
    resources :replies, only: :destroy
  end
end
