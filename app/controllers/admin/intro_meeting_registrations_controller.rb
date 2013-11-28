class Admin::IntroMeetingRegistrationsController < Admin::BaseController
  before_action :set_meeting, only: [:index, :destroy]
  before_action :set_registration, only: [:destroy]

  def index
    @registrations = @meeting.registrations
  end

  def destroy
    @registration.destroy
    flash[:notice] = "Intro meeting registration has been deleted."
    redirect_to admin_intro_meeting_registrations_path(@meeting)
  end
  private

    def set_meeting
      @meeting = IntroMeeting.find(params[:intro_meeting_id])
    end

    def set_registration
      @registration = @meeting.registrations.find(params[:id])
    end
end
