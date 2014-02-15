Lib::Application.routes.draw do

    resources :books do
  collection do
    get 'view_books'
    get 'rank_book'
    patch 'update_book_rank'
    get 'search_by_title'
    get 'show_search_by_title'
  end
end

  
  devise_for :users 
  get "welcom/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcom#index'
  resources :cats do
    collection do
      get 'view_cats'
      get 'search_by_category'
      get 'show_search_by_category'
    end
  end
  
  resources :userbookranks
  
  resources :comments do
    collection do
      get 'index_by_book'
    end
  end
  
  resources :borrows do
    collection do
      get 'index_by_user'
      get 'return_book'
      get 'sendemail'
    end
  end
 # match 'books/view_books' => 'books#view_books'
  
  resources :authors do
    collection do
      get 'view_authors'
      get 'search_by_author'
      get 'show_search_by_author'
    end
  end

  
  resources :admins do
    collection do
      get 'edit_user'
    end
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
