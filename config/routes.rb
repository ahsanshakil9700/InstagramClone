Rails.application.routes.draw do

  root to: 'accounts#index'

  devise_for :accounts,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  devise_scope :user do
    authenticated :accounts do
      root 'accounts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  resources :accounts, only: [:show, :index, :edit, :update]

  # dashboard
  get '/dashboard', to: 'accounts#index'

end
