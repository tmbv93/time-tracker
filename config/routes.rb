Rails.application.routes.draw do
  root 'days#index'

  resources :days, only: [:index, :show, :update]
  resources :work_sessions, only: [:create, :update] do
    resources :activities, only: [:create]
  end
end
