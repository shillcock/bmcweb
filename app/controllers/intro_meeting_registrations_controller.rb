class IntroMeetingRegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_meeting

  def new
    @registration = IntroMeetingRegistration.new
  end

  def create
    @registration = @meeting.registrations.create(intro_meeting_registration_params)

    if @registration.save
      flash[:notice] = "Registration has been created."
      redirect_to root_path
    else
      flash[:alert] = "Registration has not been created."
      render :new
    end
  end

  private

    def set_meeting
      @meeting = IntroMeeting.find(params[:intro_meeting_id])
    end

    def intro_meeting_registration_params
      params.require(:intro_meeting_registration).permit(:first_name, :last_name, :email)
    end
end
