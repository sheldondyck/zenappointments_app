ZenAppointmentsApp::Application.routes.draw do
  get "dashboard/index"
  get 'employees/index',          :to => 'employees#index'

  get 'payments/index',           :to => 'payments#index'

  get 'users/index',              :to => 'users#index'
  resources :users

  get   'clients/search',         :to => 'clients#search'
  resources :clients

  get   '/dashboard',             :to => 'dashboard#index'

  get   'accounts/payments',      :to => 'accounts#payments'
  get   'accounts/welcome',       :to => 'accounts#welcome'
  get   'accounts/tutorial',      :to => 'accounts#tutorial'
  get   'accounts/reports',       :to => 'accounts#reports' #TODO: where should the reports be located?
  get   'signup',                 :to => 'accounts#new'
  resources :accounts

  get   'appointments',               :to => 'appointments#index'
  get   'appointments/new',           :to => 'appointments#new'
  post  'appointments/create',        :to => 'appointments#create'
  post  'appointments/move',          :to => 'appointments#move'
  post  'appointments/update',        :to => 'appointments#update'
  post  'appointments/destroy',       :to => 'appointments#destroy'
  get   'appointments/day/(:date)',   :to => 'appointments#day',      :as => 'appointments_day'
  get   'appointments/week/(:date)',  :to => 'appointments#week',     :as => 'appointments_week'
  get   'appointments/month/(:date)', :to => 'appointments#month',    :as => 'appointments_month'
  get   'appointments/year/(:date)',  :to => 'appointments#year',     :as => 'appointments_year'
  #resources :appointments

  get   'signin',                 :to => 'sessions#new'
  post  'signin',                 :to => 'sessions#create'
  get   'signout',                :to => 'sessions#destroy'

  root  'sessions#new'
end
