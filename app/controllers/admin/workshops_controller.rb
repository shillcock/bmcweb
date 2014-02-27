class Admin::WorkshopsController < AdminController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @workshops = Workshop.all
    respond_with(@workshops)
  end

  def new
    @workshop = Workshop.new
    respond_wth(@workshop)
  end

  def create
    @workshop = Workshop.new(workshop_params)
    if @workshop.save
      flash[:notice] = "Workshop has been created."
    end
    respond_with(@workshop)
  end

  def show
    @sections = @workshop.sections.order('created_at ASC')
    respond_with(@workshop)
  end

  def edit
    respond_with(@workshop)
  end

  def update
    if @workshop.update(workshop_params)
      flash[:notice] = "Workshop has been updated."
    end
    respond_with(@workshop)
  end

  def destroy
    @workshop.destroy
    flash[:notice] = "Workshop has been deleted."
    respond_with([:admin,  @workshop])
  end

  private
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    def workshop_params
      params.require(:workshop).permit(:title)
    end
end
