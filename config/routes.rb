ZenAppointmentsApp::Application.routes.draw do
  get 'employees/index',          :to => 'employees#index'

  get 'payments/index',           :to => 'payments#index'

  get 'users/index',              :to => 'users#index'
  resources :users

  get   'clients/search',         :to => 'clients#search'
  resources :clients

  get   'accounts/payments',      :to => 'accounts#payments'
  get   'accounts/welcome',       :to => 'accounts#welcome'
  get   'accounts/tutorial',      :to => 'accounts#tutorial'
  get   'accounts/reports',       :to => 'accounts#reports' #TODO: where should the reports be located?
  get   'accounts/home',          :to => 'accounts#home' #TODO: where should the home screen be located?
  get   'signup',                 :to => 'accounts#new'
  resources :accounts

  get   'appointments',               :to => 'appointments#index'
  get   'appointments/new',           :to => 'appointments#new'
  post  'appointments/create',        :to => 'appointments#create'
  post  'appointments/move',          :to => 'appointments#move'
  post  'appointments/update',        :to => 'appointments#update'
  post  'appointments/destroy',       :to => 'appointments#destroy'
  get   'appointments/day/(:date)',   :to => 'appointments#day'
  get   'appointments/week/(:date)',  :to => 'appointments#week'
  get   'appointments/month/(:date)', :to => 'appointments#month'
  get   'appointments/year/(:date)',  :to => 'appointments#year'
  #resources :appointments

  get   'signin',                 :to => 'sessions#new'
  post  'signin',                 :to => 'sessions#create'
  get   'signout',                :to => 'sessions#destroy'

  root  'sessions#new'
end
