class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTH_USER"], password: ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
  include Clearance::Controller
  before_action :authorize
  protect_from_forgery with: :exception

  protected

    def redirect_unless_user_is_admin
      unless current_user_is_admin?
        flash[:alert] = "You do not have permission to view that page."
        redirect_to root_url
      end
    end

    def current_user_is_admin?
      current_user && current_user.admin?
    end
    helper_method :current_user_is_admin?

    def admins_only(&block)
      block.call if current_user_is_admin?
    end
    helper_method :admins_only
end
