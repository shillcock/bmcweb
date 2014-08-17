class My::CreditCardsController < MyController
  before_action :set_user, only: [:update]

  def update
    UpdateUsersDefaultCreditCard.perform_async(@user.id, params[:stripeToken])
    flash[:notice] = "Your credit card was sucessfully updated!"

    #if @user.update_credit_card(params[:stripeToken])
    #   flash[:notice] = "Your credit card was sucessfully updated!"
    # else
    #   flash[:error] = "Unable to update credit card at this time. Please try again later."
    # end

    redirect_to my_alumni_membership_path
  end

  # def status
  #   raise ActionController::RoutingError.new('not found') unless @membership
  #   render json: { status: @membership.status }
  # end

  private

    def set_user
      @user = current_user
    end
end
