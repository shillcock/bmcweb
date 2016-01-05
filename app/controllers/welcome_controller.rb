class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :info, :schedule]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end

  def info
  end

  def schedule
    @workshops = Workshop.bt1_or_bt2_active_or_upcoming
  end
end

