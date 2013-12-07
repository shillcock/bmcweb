class Admin::UsersController < Clearance::UsersController
  layout 'admin'
  before_action :redirect_unless_user_is_admin
  skip_before_filter :avoid_sign_in # clearance defaults to signing in user after create

  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def edit
  end

  def update
    if @user == current_user
      params[:user].delete(:admin)
    end

    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render :edit
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
    end

    redirect_to admin_users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end
end
