BreakthroughForMen::Application.routes.draw do
  root to: "welcome#index"
  get "what_is_breakthrough", to: "welcome#info"
  get "schedule", to: "welcome#schedule"

  get "contact", to: "contact#new"
  resource "contact", controller: :contact, only: [:create]

  resources :intro_meetings, only: [:index] do
    resources :registrations, controller: "intro_meeting_registrations", only: [:new, :create]
  end

  get "donate", to: "donations#new"
  post "donate", to: "donations#create"

  namespace :admin do
    root to: "dashboard#index"
    get "dashboard", to: "dashboard#index"

    resources :users
    resources :intro_meetings, only: [:index, :new, :create, :destroy] do
      resources :registrations, controller: "intro_meeting_registrations", only: [:index, :destroy]
    end
  end
end
