class Admin::IntroMeetingsController < AdminController
  before_action :set_intro_meeting, only: [:destroy]

  def index
    @intro_meetings = IntroMeeting.all
  end

  def new
    @intro_meeting = IntroMeeting.new
  end

  def create
    @intro_meeting = IntroMeeting.new(intro_meeting_params)

    if @intro_meeting.save
      flash[:notice] = "Intro meeting has been created for #{@intro_meeting.date}."
      redirect_to admin_intro_meetings_path
    else
      flash[:alert] = "Intro meeting has not been created."
      render :new
    end
  end

  def destroy
    @intro_meeting.destroy
    flash[:notice] = "Intro meeting has been deleted."
    redirect_to admin_intro_meetings_path
  end

  private

    def set_intro_meeting
      @intro_meeting = IntroMeeting.find(params[:id])
    end

    def intro_meeting_params
      params.require(:intro_meeting).permit(:date, :starts_at, :ends_at)
    end
end
