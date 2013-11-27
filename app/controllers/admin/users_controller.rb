class Admin::UsersController < Clearance::UsersController
  before_action :authorize
  before_action :redirect_unless_user_is_admin
  skip_before_filter :avoid_sign_in

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end
end
