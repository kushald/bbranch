Bbranch::Application.routes.draw do

  get 'ifsc/:bank_name/' => 'ifscs#search_by_name'
  get 'ifsc/:bank_name/:state' => 'ifscs#search_by_state'
  get 'ifsc/:bank_name/:state/:district' => 'ifscs#search_by_district'
  get 'ifsc/:bank_name/:state/:district/:branch' => 'ifscs#search_by_branch'




  get "ifscs" => 'ifscs#index'
  get "neft_banks/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :banks

  resources :neft_banks
  # You can have the root of your site routed with "root"
  root 'ifscs#index'
  #get 'ifsc/:state/:district' => 'banks#test'
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
