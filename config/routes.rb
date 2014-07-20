require 'sidekiq/web'

BreakthroughForMen::Application.routes.draw do
  root to: "welcome#index"

  get "what_is_breakthrough", to: "welcome#info"
  get "schedule", to: "welcome#schedule"

  get "contact", to: "contact#new"
  resource "contact", controller: :contact, only: [:create]

  resource :profile, only: [:show, :update]

  resources :intro_meetings, only: [:index] do
    resources :registrations, controller: "intro_meeting_registrations", only: [:new, :create]
  end

  get "donate", to: "donations#new"
  post "donate", to: "donations#create"

  namespace :admin do

    resources :users do
      resource :alumni_membership
      member do
        post :update_credit_card
      end
    end

    resources :intro_meetings, only: [:index, :new, :create, :destroy] do
      resources :registrations, controller: "intro_meeting_registrations", only: [:index, :destroy]
    end

    resources :workshops do
      resources :lessons
      resources :sections
    end

    resources :donations, only: [:index, :show]

    resources :sections, only: [] do
      resources :meetings, only: [:index, :update]
      resource :roster do
        member do
          post :add
          delete :remove
        end
      end
    end

    root to: "dashboard#index"
    get "dashboard", to: "dashboard#index"
  end

  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    mount Sidekiq::Web, at: "/admin/sidekiq", as: "admin_sidekiq"
  end

  mount StripeEvent::Engine, at: "/stripe-webhook"
end
