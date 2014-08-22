class My::PaymentsController < MyController
  before_action :set_user, only: [:index, :show]
  before_action :set_payment, only: [:show]

  def index
    @payments = @user.payments
  end

  def show
  end

  private

    def set_user
      @user = current_user
    end

    def set_payment
      @payment = @user.payments.find(:id)
    end
end
