Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
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

  resources :messages

  get  'track_package/:id' => 'shipping#track'
  post 'generate_shipping_label' => 'shipping#generate_label'

end

# Add extra spree routes here
Spree::Core::Engine.routes.prepend do

  # Add the capability to delete an order on the front-end
  resources :orders do
    member do
      delete 'cancel'
    end
  end

end

# Add new custom routes here
Spree::Core::Engine.routes.draw do

  post 'change_order_status/:id' => 'orders#change_status'
  post 'duplicate_order/:id' => 'orders#duplicate_order'
  post 'duplicate_item/:id' => 'orders#duplicate_item'
  post 'change_order_manufacturer_tracking/:id' => 'orders#change_manufacturer_tracking_number'
  post 'save_for_later/:id' => 'orders#save_for_later'
  post 'move_to_cart/:id' => 'orders#move_to_cart'

  namespace :admin do
    resources :reports, only: [:index] do
      collection do
        get :sales_total
        post :sales_total
        get :client_orders
        post :client_orders
        get :csv_uploads
        post :csv_uploads
        get :manufacturing_times
        post :manufacturing_times
        get :client_rankings
        post :client_rankings
      end
    end
  end

end
