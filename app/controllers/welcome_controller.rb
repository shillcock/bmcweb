class WelcomeController < ApplicationController
  skip_before_action :authorize, only: [:index, :info, :schedule]

  def index
    @upcoming_intro_meetings = IntroMeeting.upcoming
  end

  def info
  end

  def schedule
    @workshops = Workshop.includes(:meetings).find_by(name: "BT1")
    # @workshops = Workshop.includes(:meetings)
    # @sections = Section.includes(:workshop, meetings: [:lesson])
  end
end

# Breakthrough I - 2014 Thursday Starting July 24
# Breakthrough 2 - 2014 Thursday Starting October 30
# Breakthrough I - 2015 Wednesday Starting February 4
# Breakthrough 2 - 2015 Wednesday Starting May 20
# Breakthrough I - 2015 Tuesday Starting May 26
# Breakthrough 2 - 2015 Tuesday Starting September 8
