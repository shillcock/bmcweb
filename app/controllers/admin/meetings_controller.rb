class Admin::MeetingsController < AdminController
  before_action :set_workshop
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = @workshop.meetings
  end

  def show
  end

  def new
    @meeting_form = MeetingForm.new(workshop: @workshop)
  end

  def create
    @meeting_form = MeetingForm.new(meeting_params.merge(workshop: @workshop))

    if @meeting_form.save
      flash[:notice] = "Meeting was successfully created."
      redirect_to [:admin, @workshop, :meetings]
    else
      render :new
    end
  end

  def edit
    @meeting_form = MeetingForm.new(workshop: @workshop, meeting: @meeting)
  end

  def update
    @meeting_form = MeetingForm.new(meeting_params.merge(workshop: @workshop, meeting: @meeting))

    if @meeting_form.save
      flash[:notice] = "Meeting was successfully updated."
      redirect_to [:admin, @workshop, @meeting_form.meeting]
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
      meeting_params = params[:meeting_form]
      if meeting_params
        # meeting_params[:end_date] = meeting_params[:start_date] if meeting_params[:end_date].blank?
        # meeting_params.permit(:title, :start_date, :start_time, :end_date, :end_time)
        meeting_params.permit(:title, :date)
      else
        {}
      end
    end
end
