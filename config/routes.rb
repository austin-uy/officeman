Rails.application.routes.draw do
  devise_for :users
  resources :choices
  resources :answers
  resources :equipment
  resources :questions
  resources :users
  root to: 'home#index', as: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
