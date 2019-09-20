Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :choices
  resources :answers
  resources :equipment
  resources :questions
  resources :users
  root to: 'home#index', as: "home" 
  
  get 'profile', as: "profile", controller:  :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
