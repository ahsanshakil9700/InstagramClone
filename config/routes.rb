Rails.application.routes.draw do

  root to: 'posts#index'

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

  resources :posts, only: [:index, :destroy, :show, :create, :edit, :update] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
  end

  # dashboard
  get '/dashboard', to: 'posts#index'

end
