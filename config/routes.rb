require 'sidekiq/web'

BMC::Application.routes.draw do
  # website homepage
  root to: "welcome#index"

  # InTouch (discourse) sso
  get "intouch/sso", to: "in_touch_sso#sso"

  # stripe webhooks
  resources :stripe_events, only: [:create]

  # clearance overrides
  resource :session, controller: "sessions", only: [:new, :create, :destroy]
  get "sign_in", to: "sessions#new", as:nil
  delete "sign_out", to: "sessions#destroy", as: nil

  # website pages
  get "what_is_breakthrough", to: "welcome#info"
  get "schedule", to: "welcome#schedule"

  # introductory meeting and registrations
  resources :intro_meetings, only: [:index] do
    resources :registrations, controller: "intro_meeting_registrations", only: [:new, :create]
  end

  # contact us
  get "contact", to: "contact#new"
  resource "contact", controller: :contact, only: [:create]

  # donate
  get "donate", to: "donations#new"
  post "donate", to: "donations#create"

  # my account
  namespace :my do
    resource :alumni_membership do
      member do
        get :status
      end
    end
    resource :profile, only: [:show, :edit, :update]
    resource :credit_card, only: [:update]
    resources :payments, only: [:index, :show]
    resources :workshops, only: [:index, :show]
  end

  # learn
  namespace :learn do
    resources :workshops, only: [:show] do
      resources :meetings, only: [:show]
    end
  end

  # admin
  namespace :admin do
    resources :users do
      resource :alumni_membership
      resources :payments, only: [:index, :show]
      member do
        get :history
        post :update_credit_card
      end
    end

    resources :intro_meetings, only: [:index, :new, :create, :destroy] do
      resources :registrations, controller: "intro_meeting_registrations", only: [:index, :destroy]
    end

    resources :workshops do
      resources :meetings
      resources :enrollments, controller: "workshop_enrollments", only: [:index, :create, :destroy]
      member do
        get :history
      end
    end

    resources :donations, only: [:index, :show]

    root to: "dashboard#index"
    get "dashboard", to: "dashboard#index"
  end

  # sidekiq
  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    mount Sidekiq::Web, at: "/admin/sidekiq", as: "admin_sidekiq"
  end
end
