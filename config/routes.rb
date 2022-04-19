Rails.application.routes.draw do
  resources :card_categories

  resources :cards do
    resources :card_expenses
  end
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}
  root to: "cards#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
