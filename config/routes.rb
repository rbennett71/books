Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :books
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end
