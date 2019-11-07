Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :answers
      resources :equipment
      resources :questions

      root to: 'users#index'
    end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :answers, except: %i[show new]
  resources :equipment, except: :show
  resources :questions, except: :show do
    get 'summary', as: 'summary'
  end

  resources :users, except: :show

  root to: 'home#index', as: 'home'

  get 'summary', as: 'summary', controller: :answers, action: :index
  put 'validate', as: 'validate', controller: :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
