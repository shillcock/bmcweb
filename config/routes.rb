BreakthroughForMen::Application.routes.draw do
  root to: 'welcome#index'

  namespace :admin do
    root to: 'base#index'
    resources :users
    resources :intro_meetings, only: [:index, :new, :create, :destroy]
  end

  resources :intro_meetings, only: [] do
    resources :registrations, controller: 'intro_meeting_registrations', only: [:new, :create]
  end
end
