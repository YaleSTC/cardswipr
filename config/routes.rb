# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  unauthenticated :user do
    root to: 'pages#home', id: 'home'
  end

  authenticated :user do
    root to: 'dashboards#index', id: 'dashboard'
  end

  # HighVoltage
  get '/dashboard' => 'dashboards#index', id: 'dashboard'

  resources :events, only: %i(new create show edit destroy) do
    resources :attendances, only: %i(new index)
  end
end
