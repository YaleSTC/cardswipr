# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  unauthenticated :user do
    root to: 'pages#home', id: 'home'
  end

  authenticated :user do
    root to: 'pages#dashboard', id: 'dashboard'
  end

  # HighVoltage
  get '/dashboard' => 'pages#dashboard', id: 'dashboard'
end
