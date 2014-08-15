class Admin::MeetingsController < AdminController
  before_action :set_workshop
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = @workshop.meetings
  end

  def show
  end

  def new
    @meeting = @workshop.meetings.build(start_time: Time.parse("6:30 PM"), end_time: Time.parse("9:30 PM"))
    @meeting.start_time = Time.parse("6:30 PM")
    @meeting.end_time = Time.parse("9:30 PM")
  end

  def create
    @meeting = @workshop.meetings.build(meeting_params)
    if @meeting.save
      flash[:notice] = "Meeting was successfully created."
      redirect_to [:admin, @workshop, @meeting]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      flash[:notice] = "Meeting was successfully updated."
      redirect_to [:admin, @workshop, @meeting]
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to [:admin, @workshop, :meetings]
  end

  private
    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def set_meeting
      @meeting = @workshop.meetings.find(params[:id])
    end

    def meeting_params
      meeting_params = params[:meeting]
      if meeting_params
        meeting_params[:end_date] = meeting_params[:start_date] if meeting_params[:end_date].blank?
        meeting_params.permit(:title, :start_date, :start_time, :end_date, :end_time)
      else
        {}
      end
    end

    def parse_datetime(value)
      DateTime.strptime(value,"%m/%d/%Y %l:%M %p").to_time
    end
end
