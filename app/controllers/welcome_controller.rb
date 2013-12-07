class WelcomeController < ApplicationController
  skip_before_action :authorize, only: [:index]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end
end
