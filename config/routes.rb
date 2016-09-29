Rails.application.routes.draw do
  get 'searches/new'

  get 'new/show'

  get 'new/edit'

  root 'trains#index'

  resources :tickets
  resources :users
  resources :routes

  resources :trains do
    resources :carriages, shallow: true

    resources :econom_carriages, controller: 'carriages', type: 'Carriage::Econom', shallow: true
    resources :business_carriages, controller: 'carriages', type: 'Carriage::Business', shallow: true
    resources :luxurious_carriages, controller: 'carriages', type: 'Carriage::Luxurious', shallow: true
    resources :seating_carriages, controller: 'carriages', type: 'Carriage::Seating', shallow: true
  end

  resources :railway_stations do
    member do
      patch :update_position
      patch :update_arrival_datetime
      patch :update_departure_datetime
    end
  end

  resource :search do
    get '/' => 'searches#new'
    post '/' => 'searches#show_results'
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
