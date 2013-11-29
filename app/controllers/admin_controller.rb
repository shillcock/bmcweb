class AdminController < ApplicationController
  before_action :authorize
  before_action :redirect_unless_user_is_admin

  def index
    redirect_to admin_dashboard_path
  end
end
