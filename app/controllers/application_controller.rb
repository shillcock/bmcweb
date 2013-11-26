class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

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
end
