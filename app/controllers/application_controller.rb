class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTH_USER"], password: ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  protected

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.for(:sign_up) << :username
    # end

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

    def after_sign_in_path_for(resource_or_scope)
      if current_user_is_admin?
        admin_root_path
      else
        my_profile_path
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
end

