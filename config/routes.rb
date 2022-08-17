# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :accounts,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' }

  devise_scope :user do
    authenticated :accounts do
      root 'accounts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # resource for accounts
  resources :accounts, only: %i[show edit update] do
    post :index
  end
  # resource for follows
  resources :follows, only: %i[create destroy]
  # resources :requests
  resources :requests, only: %i[create index update destroy]

  resources :posts, only: %i[index destroy show create edit update] do
    resources :photos, only: [:create]
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, only: %i[index create destroy], shallow: true
  end

  resources :stories, only: %i[show create destroy] do
    resource :photos, only: [:create]
  end

  # Search function route
  post 'search/account' => 'accounts#search', as: :search_user

  # dashboard
  get '/dashboard', to: 'posts#index'
end
