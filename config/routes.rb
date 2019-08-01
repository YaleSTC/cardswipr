# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  unauthenticated :user do
    root to: 'pages#home', id: 'home'
  end

  authenticated :user do
    root to: 'pages#home', id: 'home'
  end

  # HighVoltage
  get '/dashboard' => 'dashboards#index', id: 'dashboard'

  resources :users, only: %i(edit update)
  resources :events, only: %i(new create show edit update destroy) do
    resources :attendances, only: %i(create index destroy) do
      collection do
        get 'export'
      end
    end
    resources :user_events, only: %i(create destroy)
  end
end
