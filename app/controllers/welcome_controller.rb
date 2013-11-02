class WelcomeController < ApplicationController
  def index
    @intro_meetings = IntroMeeting.all
  end
end
