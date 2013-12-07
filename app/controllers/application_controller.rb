class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :authorize
  protect_from_forgery with: :exception

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, alert: exception.message
  # end

  protected

    def redirect_unless_user_is_admin
      unless current_user_is_admin?
        flash[:alert] = 'You do not have permission to view that page.'
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
