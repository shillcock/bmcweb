class Admin::AlumniMembershipsController < AdminController
  before_action :set_user
  before_action :set_membership, only: [:show, :edit, :update, :status]

  def new
    @membership = AlumniMembership.new(amount: 40, deactivated_on: Time.zone.today)
  end

  def create
    @membership  = @user.alumni_membership || @user.build_alumni_membership(membership_params)

    if @membership.save
      CreateStripeSubscription.perform_async(@membership.id)
      flash[:notice] = "Alumni membership has been created."
      redirect_to [:admin, @user]
    else
      flash.now[:alert] = "Alumni membership has not been created."
      render :new
    end
  end

  def show
    redirect_to [:new, :admin, @user, :alumni_membership] unless @membership && @membership.active?
  end

  def status
    raise ActionController::RoutingError.new('not found') unless @membership
    render json: { status: @membership.status }
  end

  def edit
  end

  def update
    if @membership.update(membership_params)
      UpdateStripeSubscription.perform_async(@membership.id)
      flash[:notice] = "Alumni membership has been updated."
      redirect_to [:admin, @user, :alumni_membership]
    else
      flash.now[:alert] = "Alumni membership has not been updated."
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_membership
      @membership = @user.alumni_membership
    end

    def membership_params
      params.require(:alumni_membership).permit(:amount, :interval, :stripe_token)
    end
end
