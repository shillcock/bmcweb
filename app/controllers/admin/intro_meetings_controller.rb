class Admin::IntroMeetingsController < Admin::BaseController
  def new
    @intro_meeting = IntroMeeting.new
  end

  def create
    @intro_meeting = IntroMeeting.new(intro_meeting_params)

    if @intro_meeting.save
      flash[:notice] = "Intro Meeting has been created for #{@intro_meeting.date}."
      redirect_to root_path
    else
      flash[:alert] = "Intro Meeting has not been created."
      render :new
    end
  end

  private
    def intro_meeting_params
      params.require(:intro_meeting).permit(:date, :starts_at, :ends_at)
    end
end
