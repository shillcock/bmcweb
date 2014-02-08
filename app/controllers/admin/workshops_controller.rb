class Admin::WorkshopsController < AdminController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]

  def index
    @workshops = Workshop.all
  end

  def new
    @workshops = Workshop.new
  end

  def create
    @workshops = Workshop.new(workshop_params)

    if @workshops.save
      flash[:notice] = "Workshop has been created."
      redirect_to admin_workshops_path
    else
      flash[:alert] = "Workshop has not been created."
      render :new
    end
  end

  def show
    @sections = @workshop.sections.order('created_at ASC')
  end

  def edit
  end

  def update
    if @workshop.update(workshop_params)
      flash[:notice] = "Workshop has been updated."
      redirect_to admin_workshops_path
    else
      flash[:alert] = "Workshop has not been updated."
      render :edit
    end
  end

  def destroy
    @workshop.destroy
    flash[:notice] = "Workshop has been deleted."
    redirect_to admin_workshops_path
  end

  private
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    def workshop_params
      params.require(:workshop).permit(:title)
    end
end
