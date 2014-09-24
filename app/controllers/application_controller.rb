class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTH_USER"], password: ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
  include Clearance::Controller
  before_action :authorize
  protect_from_forgery with: :exception

  def sign_in(user)
    update_tracked_fields(user) if user
    super(user)
  end

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


    def update_tracked_fields(user)
      user.sign_in_count ||= 0
      user.sign_in_count += 1
      user.last_sign_in_at = Time.now.utc
      user.save(validate: false)
    end
end
