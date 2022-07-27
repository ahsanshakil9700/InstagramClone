Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  # dashboard
  get '/dashboard', to: 'accounts#index'

  root to: 'accounts#index'
end
