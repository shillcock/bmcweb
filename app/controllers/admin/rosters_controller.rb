class Admin::RostersController < AdminController
  before_action :set_section
  before_action :set_workshop

  def show
    @roster = @section.roster
    @users = users_not_enrolled
    @roles = roles
  end

  def edit
    @roster = @section.roster
  end

  def update
  end

  # add a participant to the roster
  def add
    if @section.add_enrollment(participant, role: participant_params[:role])
      flash[:notice] = "User added to section."
    else
      flash[:alert] = "User was not added to section."
    end

    redirect_to [:admin, @section, :roster]
  end

  # remove a participant from the roster
  def remove
    @section.remove_enrollment(participant)
    flash[:notice] = "User removed from section."
    redirect_to [:admin, @section, :roster]
  end

  private

    def set_section
      @section = Section.find(params[:section_id])
    end

    def set_workshop
      @workshop = @section.workshop
    end

    def participant
      user = User.find(params[:user_id] || params[:participant][:user_id])
    end

    def roles
      [["Student", :student], ["Educator", :educator]]
    end

    def users_not_enrolled
      users = User.all - @section.enrollments
    end

    def participant_params
      params.require(:participant).permit(:user_id, :role)
    end
end
