class Admin::LessonsController < AdminController
  before_action :set_workshop
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lesson = @workshop.lessons
  end

  def new
    @lesson = @workshop.lessons.build
  end

  def create
    @lesson = @workshop.lessons.build(lessons_params)

    if @lesson.save
      flash[:notice] = "Lesson has been created."
      redirect_to admin_workshop_lessons_path(@workshop)
    else
      flash[:alert] = "Lesson has not been created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = "Lesson has been updated."
      redirect_to admin_workshop_lessons_path(@workshop)
    else
      flash[:alert] = "Lesson has not been updated."
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    flash[:notice] = "Lesson has been deleted."
    redirect_to [:admin, @workshop]
  end

  private

    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def set_lesson
      @lesson = @workshop.lessons.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :summary, :lesson_number)
    end
end
