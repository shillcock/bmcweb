class Admin::PaymentsController < AdminController
  before_action :set_user, only: [:index, :show]
  before_action :set_payment, only: [:show]

  def index
    @payments = @user.payments
  end

  def show
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_payment
      @payment = @user.payments.find_by(guid: params[:id])
    end
end
