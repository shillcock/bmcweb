class Admin::MeetingsController < AdminController
  before_action :load_workshop
  #before_action :set_meeting, only: [:update]

  def index
    load_meetings

    # if (params[:start] && params[:end])
    #   @meetings = @workshop.meetings.where("starts_at >= ? and ends_at <= ?", params[:start], params[:end])
    # else
    #   @meetings = @workshop.meetings
    # end
  end

  def show
    load_meeting
  end

  def new
    build_meeting
  end

  def create
    build_meeting
    save_meeting or render :new
  end

  def edit
    load_meeting
    build_meeting
  end

  def update
    load_meeting
    build_meeting
    save_meeting or render :edit

    # respond_to do |format|
    #   if @meeting.update(meeting_params)
    #     format.html { redirect_to [@workshop, @meeting], notice: "Meeting was successfully udpated." }
    #     format.json { head :no_content }
    #   else
    #     format.html { render :edit}
    #     format.json { render json: @meeting.errors, status: :unpreocessible_entity }
    #   end
    # end
  end

  def destroy
    load_meeting
    @meeting.destroy
    redirect_to [:admin, @workshop, :meetings]
  end

  private
    def load_workshop
      @workshop ||= workshop_scope.find(params[:workshop_id])
    end

    def load_meetings
      @meetings ||= meeting_scope.to_a
    end

    def load_meeting
      @meeting ||= meeting_scope.find(params[:id])
    end

    def build_meeting
      @meeting ||= meeting_scope.build
      @meeting.attributes = meeting_params
    end

    def save_meeting
      if @meeting.save
        redirect_to [:admin, @workshop, @meeting]
      end
    end

    def meeting_params
      meeting_params = params[:meeting]
      if meeting_params
        meeting_params[:starts_at] = parse_date_time(meeting_params[:starts_at])
        meeting_params[:ends_at] = parse_date_time(meeting_params[:ends_at])
        meeting_params.permit(:title, :meeting_number, :starts_at, :ends_at)
      else
        {}
      end
    end

    def meeting_scope
      @workshop.meetings
    end

    def workshop_scope
      Workshop.all
    end

    def parse_date_time(value)
      DateTime.strptime(value,'%m/%d/%Y %l:%M %p')
    end
end
