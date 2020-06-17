Rails.application.routes.draw do
  resources :questions
  resources :acceptance_criteria
  resources :satisfaction_questionaries
  resources :visits
  resources :customers
  resources :routes
  resources :goals
  resources :salesmen
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/contact', to: 'home#contact', as: :contact

  namespace :admin do
    get '/', to: 'home#index', as: :root
  end
end
