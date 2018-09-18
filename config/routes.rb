Rails.application.routes.draw do
  root 'welcome#index'

  resources :activities, only: [:create]
  resources :work_sessions, only: [:create]
end
