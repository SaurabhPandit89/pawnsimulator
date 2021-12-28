# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :boards, only: :index
  resources :moves, except: %i[index new edit]

  root 'boards#index'
end
