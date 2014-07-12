class WelcomeController < ApplicationController
  skip_before_action :authorize, only: [:index, :info, :schedule]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end

  def info
  end

  def schedule
    @sections = Section.includes(:workshop, meetings: [:lesson])
  end

  private

end
