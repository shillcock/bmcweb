class WelcomeController < ApplicationController
  skip_before_action :authorize, only: [:index, :info]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end

  def info
  end
end
