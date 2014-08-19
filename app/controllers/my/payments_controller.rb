class My::PaymentsController < MyController
  before_action :set_user, only: [:index, :show]

  def index
  end

  def show
    # @payment = @user.payments
  end

  private

    def set_user
      @user = current_user
    end
end
