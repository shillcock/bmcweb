class Admin::DashboardController < AdminController
  def index
    @dashboard = Dashboard.new
  end
end
