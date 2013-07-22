ZenAppointmentsApp::Application.routes.draw do
  #resources :sessions,            :only => [:new, :create, :destroy]
  resources :accounts

  get   'signin',                 :to => 'sessions#new'
  post  'signin',                 :to => 'sessions#create'
  get   'signout',                :to => 'sessions#destroy'

  get   'signup',                 :to => 'accounts#new'

  get   'appointments',           :to => 'appointments#index'

  # TODO: change is not a good name for this since we are not changing the
  # appointment only the date viewed
  get   'appointments/change',    :to => 'appointments#change'

  root  'sessions#new'
end
