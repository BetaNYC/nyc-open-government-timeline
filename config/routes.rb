NYCOpenGovernment::Application.routes.draw do

  root 'pages#timeline'

  get '/events/categories' => 'eventcategories#delete'
  get '/events/categories/:category' => 'categories#show'

<<<<<<< HEAD:NYC-Open-Government/config/routes.rb
  get '/timeline' => 'pages#timeline'
  get '/events/format/outline' => 'pages#outline'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/database' => 'pages#database'
  get '/api' => 'pages#api'
  get '/' => 'pages#home'

  resources :categories
=======

  resources :categories 
  get '/api/categories/name=:name' => 'categories#api_by_name'
  get '/api/events/name=:name' => 'events#api_by_name'
>>>>>>> 8c57c38137cca6f6a405f228a70f88e089d15f1a:config/routes.rb

  resources :events do
    resources :comments
  end

<<<<<<< HEAD:NYC-Open-Government/config/routes.rb
=======
  get '/timeline' => 'pages#timeline'

  

>>>>>>> 8c57c38137cca6f6a405f228a70f88e089d15f1a:config/routes.rb
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
