class WelcomeController < ApplicationController
  def index
    @upcomming_intro_meetings = IntroMeeting.upcomming
  end
end
