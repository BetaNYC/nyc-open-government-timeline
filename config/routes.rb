NYCOpenGovernment::Application.routes.draw do
  
  # devise authentication solution
  devise_for :users#, :path_names => { sign_up => "register" }

  # home
  root :to => 'pages#timeline'

  # angular
  get '/events-angular', :to => redirect('/app/index.html#/events')
  get '/categories-angular', :to => redirect('/app/index.html#/categories')
  get '/404-angular', :to => redirect('app/index.html#/404')

  # custom category routes
  get '/events/categories' => 'eventcategories#delete'
  get '/events/categories/:category' => 'categories#show'

  # static pages
  get '/home' => 'pages#home'
  get '/d3timeline' => 'pages#d3timeline'
  get '/barchart' => 'pages#barchart'
  get '/events/format/outline' => 'pages#outline'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/database' => 'pages#database'

  # api
  get '/api' => 'pages#api'
  get '/api/categories/name=:name' => 'categories#api_by_name'
  get '/api/events/name=:name' => 'events#api_by_name'
  get '/timelineJS' => 'pages#timeline_json'

  resources :categories 

  resources :events do
    resources :comments
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
