Rails.application.routes.draw do
  resources :card_categories
  resources :card_expenses, except: :index

  resources :cards do
    get :card_expenses, to: "card_expenses#index"
  end
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
