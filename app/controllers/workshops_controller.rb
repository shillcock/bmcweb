class WorkshopsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @workshops = Workshop.bt1_or_bt2_active_or_upcoming
  end
end
