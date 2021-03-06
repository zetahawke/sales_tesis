Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/contact', to: 'home#contact', as: :contact
  
  namespace :admin do
    get '/', to: 'home#index', as: :root
    resources :questions
    resources :acceptance_criteria
    resources :satisfaction_questionaries do
      collection do
        get 'new_massive'
        post 'create_massive'
      end
    end
    resources :visits
    resources :customers do
      get 'create_token'
    end
    resources :routes
    resources :goals
    resources :money_goals

    resources :salesmen do
      get 'create_token'
    end
  end

  namespace :public do
    get '/sq', to: 'satisfaction_questionaries#by_token'
    
    resources :answers, only: [:create, :update]

    namespace :customers do
      resources :visits, only: [:index, :update, :edit]
    end

    namespace :salesmen do
      resources :visits, only: [:index, :update, :edit]
    end

  end
end
