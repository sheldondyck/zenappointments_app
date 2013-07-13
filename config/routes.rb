ZenAppointmentsApp::Application.routes.draw do
  resources :sessions,          :only => [:new, :create, :destroy]
  resources :accounts

  get 'appointments',           :to => 'appointments#index'
  # TODO: change is not a good name for this since we are not changing the
  # appointment only the date viewed
  get 'appointments/change',    :to => 'appointments#change'
  get 'login',                  :to => 'sessions#new'
  get 'logout',                 :to => 'sessions#destroy'
  get 'signup',                 :to => 'accounts#new'
  root 'sessions#new'

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
#== Route Map
# Generated on 07 Jul 2013 11:41
#
#            sessions POST   /sessions(.:format)            sessions#create
#         new_session GET    /sessions/new(.:format)        sessions#new
#             session DELETE /sessions/:id(.:format)        sessions#destroy
#        appointments GET    /appointments(.:format)        appointments#index
# appointments_change GET    /appointments/change(.:format) appointments#change
#               login GET    /login(.:format)               sessions#new
#              logout GET    /logout(.:format)              sessions#destroy
#                root GET    /                              sessions#new
