class Admin::MeetingsController < ApplicationController
  before_action :set_section
  before_action :set_meeting, only: [:update]

  def index
    if (params[:start] && params[:end])
      @meetings = @section.meetings.where("starts_at >= ? and ends_at <= ?", params[:start], params[:end])
    else
      @meetings = @section.meetings
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to [@section, @meeting], notice: "Meeting was successfully udpate." }
        format.json { head :no_content }
      else
        format.html { render :edit}
        format.json { render json: @meeting.errors, status: :unpreocessible_entity }
      end
    end
  end

  private
    def set_section
      @section = Section.find(params[:section_id])
    end

    def set_meeting
      @meeting = @section.meetings.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:title, :starts_at, :ends_at)
    end
end
