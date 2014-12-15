Rails.application.routes.draw do

  resources :repair_acceptance_certificate_lines

  resources :repair_acceptance_certificates

  resources :purchasing_order_lineitems

  resources :purchasing_orders

  resources :reports

  resources :meetings

  devise_for :users
  namespace :admin do
    resources :manage_users do
      collection do
        get :approve_user
      end
    end 
  end

  resources :fixedassets do
    resources :transfer, controller: "fixedasset_transfer"
    resources :sell, shallow: true, controller: "fixedasset_sell"
    resources :depreciate, shallow:true, controller: "fixedasset_depreciate"
    
    member do
      get :clone
    end

    collection do
      get :print_report
      post :do_print
      get :reports
      post :do_batch_redep
    end
  end

  #get 'fixedassets/part/:id', to: 'fixedassets#show_part'
  #get 'fixedassets/show_part/:id', to: 'fixedassets#show_part'

  resources :quality_testings do
    collection do 
      get :search, :action => 'search_post', :as => 'search_post'
      get 'search/:q', :action => 'search', :as => 'search'
      post :do_query
      post :do_query_detail
    end
  end  
  resources :departments do
    collection do 
    get :parts
    post :update_parts
    end

    resources :parts, controller: "fixedasset_parts"
  end
  resources :vendors 

  resources :materials
  resources :material_cat_lv1s
  resources :material_cat_lv2s
  resources :material_vendors
  resources :acceptance_certifications

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => "fixedassets#index"
  
  resources :meetings do
    resources :reports
  end

  resources :purchasing_orders do
    resources :purchasing_order_lineitems
  end
  
  resources :repair_acceptance_certificates do
    resources :repair_acceptance_certificate_lines
  end
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
