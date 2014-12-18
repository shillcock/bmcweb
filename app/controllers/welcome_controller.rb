class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :info, :schedule]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end

  def info
  end

  def schedule
    @workshops = Workshop.includes(:meetings).bt1_or_bt2
  end
end
