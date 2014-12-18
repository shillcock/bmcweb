class Admin::UsersController < AdminController
  layout 'admin'
  before_action :redirect_unless_user_is_admin

  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_credit_card, :history]

  def index
    @users = User.all.includes(:alumni_membership)
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      CreateStripeCustomer.perform_async(@user.id)
      #SubscribeToNewsletter.perform_async(@user.id)
      flash[:notice] = "User has been created."
      redirect_to [:edit, :admin, @user]
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
      redirect_to [:admin, @user]
    else
      flash[:alert] = "User has not been updated."
      render :edit
    end
  end

  def update_credit_card
    UpdateUsersDefaultCreditCard.new.perform(@user.id, params[:stripeToken])
    flash[:notice] = "Your credit card was sucessfully updated!"

    redirect_to [:edit, :admin, @user, :alumni_membership]

    # UpdateUsersDefaultCreditCard.perform_async(@user.id, params[:stripeToken])
    # if @user.update_credit_card(params[:stripeToken])
    #   flash[:notice] = "Your credit card was sucessfully updated!"
    #   #redirect_to
    # else
    #   flash[:error] = "Unable to update credit card at this time. Please try again later."
    # end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
    else
      DeleteStripeCustomer.perform_async(@user.stripe_customer_id) if @user.stripe_customer_id.present?
      @user.destroy
      flash[:notice] = "User has been deleted."
    end

    redirect_to admin_users_path
  end

  def history
    @history = @user.versions
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :username, :password, :admin,
        :address1, :address2, :city, :state, :zip_code, :phone_number, :birthday)
    end
end
