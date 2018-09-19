Rails.application.routes.draw do
  root 'welcome#index'

  resources :work_sessions, only: [:create] do
    resources :activities, only: [:create]
  end
end
