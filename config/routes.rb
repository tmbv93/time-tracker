Rails.application.routes.draw do
  root 'welcome#index'

  resources :log_events, only: [:index, :create]
end
