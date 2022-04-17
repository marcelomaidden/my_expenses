Rails.application.routes.draw do
  resources :cards
  resources :card_categories
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
