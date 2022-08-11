Rails.application.routes.draw do

  root to: 'posts#index'

  post 'follow/account' => 'follows#follow_user', as: :follow_user
  delete 'unfollow/account' => 'follows#unfollow_user', as: :unfollow_user
  post 'request/account' => 'requests#create', as: :request_user
  post 'remove-request/account' => 'requests#remove_follow_request', as: :remove_request
  post 'search/account' => 'accounts#search', as: :search_user


  resources :follows, only: [:create]

  resources :requests

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

  resources :stories, only: [:show, :create, :destroy] do
    resource :photos, only: [:create]
  end


  # dashboard
  get '/dashboard', to: 'posts#index'


end
