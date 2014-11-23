Rails.application.routes.draw do
  get 'pages/question' => 'pages#question'
  get 'pages/badge' => 'pages#badge'
  get 'new_threads/list' => 'new_threads#list'
  get 'pages/credits' => 'pages#credits'
  get 'flags/search' => 'flags#search'
  get 'blockeds/list' => 'blockeds#list'
  get 'google351310b5ada0562f.html' => 'pages#google351310b5ada0562f'
 


  resources :blockeds

  resources :activities

  resources :flags

  post 'new_threads/search' => 'new_threads#search'

  get 'reply_flags/:id' => 'reply_flags#destroy'
  get 'reply_flags' => 'reply_flags#index'
  post 'reply_flags' => 'reply_flags#create'

  get 'new_thread_flags/:id' => 'new_thread_flags#destroy'
  get 'new_thread_flags' => 'new_thread_flags#index'
  post 'new_thread_flags' => 'new_thread_flags#create'
  
  resources :like_counts, :only => [:create]

  resources :dislike_counts, :only => [:create]

  resources :like_count_replies, :only => [:create]

  resources :dislike_count_replies, :only => [:create]

  devise_for :users, :controllers => {:registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_for :admins

  get 'replies/:id/delete' => 'replies#delete'
  resources :replies

  resources :new_threads do
    resources :replies
  end


  delete 'reply_flags/:id' => 'reply_flags#destroy'
  post 'new_threads/search' => 'new_threads#search'

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
   root :to => 'new_threads#index'
end
