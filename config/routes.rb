ZenAppointmentsApp::Application.routes.draw do
  get 'users/index',              :to => 'users#index'
  get 'employees/index',          :to => 'employees#index'
  get 'clients/index',            :to => 'clients#index'

  get   'accounts/welcome',       :to => 'accounts#welcome'
  get   'accounts/tutorial' ,     :to => 'accounts#tutorial'
  resources :accounts
  get   'signup',                 :to => 'accounts#new'

  get   'signin',                 :to => 'sessions#new'
  post  'signin',                 :to => 'sessions#create'
  get   'signout',                :to => 'sessions#destroy'

  get   'appointments',           :to => 'appointments#index'

  # TODO: change is not a good name for this since we are not changing the
  # appointment only the date viewed
  get   'appointments/change',    :to => 'appointments#change'

  root  'sessions#new'
end
