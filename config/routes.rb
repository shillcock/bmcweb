require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, controllers: {
      passwords: "user/passwords",
      registrations: "user/registrations",
      sessions: "user/sessions"
  }

  devise_scope :user do
    get "log_in", to: "user/sessions#new"
  end

  # clearance
  #get "/sign_in" => "sessions#new", as: :sign_in
  #delete "/sign_out" => "sessions#destroy", as: :sign_out
  # get "/sign_up" => "clearance/users#new", as: :sign_up

  #resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  #resource :session, controller: "clearance/sessions", only: [:create]
  #resource :session, controller: "sessions", only: [:new, :create, :destroy]

  #resources :users, controller: "clearance/users", only: [:create] do
  #  resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  #end

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

  # website homepage
  root to: "welcome#index"

  # InTouch (discourse) sso
  get "intouch/sso", to: "in_touch_sso#sso"

  # stripe webhooks
  resources :stripe_events, only: [:create]

  # sidekiq
  # authenticate :user, -> { |user| user.admin? } do
  #   mount Sidekiq::Web, at: "/admin/sidekiq"
  # end

  #constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
  #  mount Sidekiq::Web, at: "/admin/sidekiq"
  #end
end

