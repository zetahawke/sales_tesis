Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/contact', to: 'home#contact', as: :contact
  
  namespace :admin do
    get '/', to: 'home#index', as: :root
    resources :questions
    resources :acceptance_criteria
    resources :satisfaction_questionaries
    resources :visits
    resources :customers
    resources :routes
    resources :goals
    resources :salesmen
  end

  namespace :public do
    get '/sq', to: 'satisfaction_questionaries#by_token'

    resources :answers, only: [:create, :update]
    resources :visits, only: [:index, :update]
  end
end
