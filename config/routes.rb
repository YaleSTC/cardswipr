UsbDistribution::Application.routes.draw do

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'home'

  resources :events do
    resources :attendance_entries, :path => :attendance, shallow: true
    get 'swipe'
    post 'lookup'
    delete 'wipe_attendance'
  end

  resources :users

  get '/distribution/personlookup', as: :distribution_personlookup

  # root to: 'distribution#home'
  # get "/pages/*id" => 'pages#show', as: :page, format: false


  get '/unauthorized', :to => redirect('/unauthorized.html')
  get '/status', :to => redirect('/status.html')
  get '/logout', :to => "application#logout"

  # High Voltage routes
  get "/*id" => 'pages#show', as: :page, format: false

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
