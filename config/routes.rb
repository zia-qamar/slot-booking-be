# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope "/api/v1" do
    resources :slots, only: :new do
      collection do
        post :book
      end
    end
  end

  # More simple approach to define routes
  # get 'slots/new', to: 'slots#new'
  # post 'slots/book', to: 'slots#book'
end
