BreakthroughForMen::Application.routes.draw do
  root to: 'welcome#index'

  resources :intro_meetings, only: [:index] do
    resources :registrations, controller: 'intro_meeting_registrations', only: [:new, :create]
  end

  namespace :admin do
    root to: "dashboard#index"
    get 'dashboard', to: 'dashboard#index'

    resources :users
    resources :intro_meetings, only: [:index, :new, :create, :destroy] do
      resources :registrations, controller: 'intro_meeting_registrations', only: [:index, :destroy]
    end
  end
end
