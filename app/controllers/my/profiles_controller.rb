class My::ProfilesController < MyController
  before_action :set_user
  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      flash[:notice] = t "my.profile.updated"
      sign_in @user, :bypass => true unless params[:user][:password].blank?

      redirect_to [:my, :profile]
    else
      render :edit
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :admin,
        :address1, :address2, :city, :state, :zip_code, :phone_number, :birthday)
    end
end

