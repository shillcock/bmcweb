class WelcomeController < ApplicationController
  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end
end
