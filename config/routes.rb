Fora::Application.routes.draw do
  root 'topics#index'

  delete 'sign_out' => 'sessions#destroy', as: :sign_out

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match 'auth/failure' => 'sessions#failure', via: :get

  get 'go/:key'  => 'nodes#show', as: :node
  get 'new/:key' => 'topics#new', as: :new_topic

  post 'like/:type/:id' => 'likes#create_or_destroy',     as: :like
  post 'bookmark/:id'   => 'bookmarks#create_or_destroy', as: :bookmark
  get  'bookmarks'       => 'bookmarks#index',            as: :bookmarks

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :nodes, only: [:index, :new, :create]

  resources :topics, except: [:edit, :update, :destroy, :new] do
    resources :replies, only: :create
  end

  resources :notifications, only: [:index, :destroy] do
    delete 'clear', on: :collection
  end

  namespace :admin do
    resources :nodes,   only: :create
    resources :topics,  only: :destroy
    resources :replies, only: :destroy
  end

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
