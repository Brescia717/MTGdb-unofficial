Rails.application.routes.draw do
  get 'payment_notifications/create'

  devise_for :users

  resources  :users, only: :show
  resources  :cards do
    resources :comments
  end
  resources  :decks do
    resources :comments
  end
  resources  :search_suggestions
  resources  :carts
  resources  :line_items

  get '/card/:multiverseid'      => 'cards#show',  as: 'card_multiverseid'
  get '/decks/:id/hand'          => 'decks#show',  as: 'draw_hand'
  get '/decks/:id/game'          => 'games#show',  as: 'new_game'

  root 'cards#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
