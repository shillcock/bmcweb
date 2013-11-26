class Admin::BaseController < ApplicationController
  before_action :authorize
  before_action :redirect_unless_user_is_admin

  def index
  end

  private

end
