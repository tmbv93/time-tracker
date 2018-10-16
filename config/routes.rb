Rails.application.routes.draw do
  resources :users
  root 'days#index'

  resources :reports, only: [:show, :create]
  resources :days, only: [:index, :show, :update]
  resources :work_sessions, only: [:create, :update] do
    resources :activities, only: [:create]
  end
  resources :activities, only: [:update]

  namespace 'overview' do
    resources :days, only: [:edit, :index]
  end
end
