class Admin::WorkshopsController < AdminController
  #before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  #respond_to :html

  def index
    load_workshops
  end

  def show
    load_workshop
    #@sections = @workshop.sections.order('created_at ASC')
    #respond_with(@workshop)
  end

  def new
    build_workshop
  end

  def create
    build_workshop
    save_workshop or render :new
    # @workshop = Workshop.new(workshop_params)
    # if @workshop.save
    #   flash[:notice] = "Workshop has been created."
    # end
    # respond_with(@workshop)
  end

  def edit
    load_workshop
    build_workshop
    # respond_with(@workshop)
  end

  def update
    load_workshop
    build_workshop
    save_workshop or render :edit
    # if @workshop.update(workshop_params)
    #   flash[:notice] = "Workshop has been updated."
    # end
    # respond_with(@workshop)
  end

  def destroy
    load_workshop
    @workshop.destroy
    redirect_to [:admin, :workshops]
    # flash[:notice] = "Workshop has been deleted."
    # respond_with([:admin,  @workshop])
  end

  def history
    load_workshop
    load_history
  end

  private
    def load_workshops
      @workshops ||= workshop_scoped.to_a
    end

    def load_workshop
      @workshop ||= workshop_scoped.find(params[:id])
    end

    def build_workshop
      @workshop ||= workshop_scoped.build
      @workshop.attributes = workshop_params
    end

    def save_workshop
      if @workshop.save
        redirect_to [:admin, @workshop]
      end
    end

    def load_history
      @history ||= @workshop.versions
    end

    def workshop_params
      workshop_params = params[:workshop]
      workshop_params ? workshop_params.permit(:title, :name) : {}
    end

    def workshop_scoped
      Workshop.all
    end
end
