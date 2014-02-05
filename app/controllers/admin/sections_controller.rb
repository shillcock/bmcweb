class Admin::SectionsController < AdminController
  before_action :set_workshop
  before_action :set_section, only: [:show, :edit, :update, :destroy, :meetings]

  def index
    if (params[:start] && params[:end])
      @sections = @workshop.sections.where("starts_at >= ? and ends_at <= ?", params[:start], params[:end])
    else
      @sections = @workshop.sections.order
    end
  end

  def new
  end

  def create
    @workshop_section = WorkshopSection.new(@workshop, section_params)
    if @workshop_section.save
      flash[:notice] = "Section has been created."
      redirect_to [:admin, @workshop, @workshop_section.section]
    else
      flash[:alert] = "Section has not been created."
      redirect_to [:admin, @workshop]
    end
  end

  def show
    @meetings = @section.meetings.order(:created_at)
    @meetings_url = admin_section_meetings_path(@section, format: :json)
    @first_meeting_date = @meetings.first.starts_at.to_date
  end
    #sectionCalendar{"data-meetings-url" => admin_section_meetings_path(@section, format: :json)}

  def edit
  end

  def update
    if @section.update(section_params)
      flash[:notice] = "Section has been updated."
      redirect_to admin_workshop_sections_path(@workshop)
    else
      flash[:alert] = "Section has not been updated."
      render :edit
    end
  end

  def destroy
    @section.destroy
    flash[:notice] = "Section has been deleted."
    redirect_to admin_workshops_path
  end

  private
    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def set_section
      @section = @workshop.sections.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:title, :start_date)
    end
end
