class Admin::ProfilesController < AdminController
  before_action :set_user

  def edit
  end

  def update
    if @user.profile and @user.profile.update(profile_params)
      redirect_to [:admin, @user], notice: "Profile was successfully updated."
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def profile_params
      params.require(:profile).permit(:address1, :address2, :city, :state, :zip_code, :phone_number, :birthday)
    end
end
