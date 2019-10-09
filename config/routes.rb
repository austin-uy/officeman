Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :answers
      resources :equipment
      resources :questions

      root to: "users#index"
    end
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :answers
  resources :equipment
  resources :questions do
    get 'summary', as: "summary"
  end
  resources :users
  root to: 'home#index', as: "home" 
  
  get 'profile', as: "profile", controller: :users
  get 'summary', as: "summary", controller: :answers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
