class Admin::WorkshopEnrollmentsController < AdminController
  before_action :set_workshop
  before_action :set_enrollment, only: [:destroy]

  def index
    @enrollment = @workshop.workshop_enrollments.build
    @participants = @workshop.roster
    @users = users_not_enrolled
    @roles = roles
  end

  def create
    @enrollment = @workshop.workshop_enrollments.build(workshop_enrollment_params)

    if @enrollment.save
      flash[:notice] = "User added to workshop."
    else
      flash[:alert] = "User was not added to workshop."
    end

    redirect_to enrollments_path
  end

  def destroy
    @enrollment.destroy
    flash[:notice] = "User removed from workshop."
    redirect_to enrollments_path
  end

  private

    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def set_enrollment
      @enrollment = @workshop.workshop_enrollments.find(params[:id])
    end

    def participant
      user = User.find(participant_params[:user_id])
    end

    def roles
      [["Student", :student], ["Educator", :educator]]
    end

    def users_not_enrolled
      users = User.all - @workshop.enrollments
    end

    def enrollments_path
      [:admin, @workshop, :enrollments]
    end

    def workshop_enrollment_params
      params.require(:workshop_enrollment).permit(:user_id, :role)
    end
end
