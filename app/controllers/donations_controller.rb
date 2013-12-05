class DonationsController < ApplicationController
  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.attributes = credit_card_params

    @donation.process_payment!

    if @donation.finished?
      flash[:notice] = "Thank you for your donation."
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def donation_params
      params.require(:donation).permit(:first_name, :last_name, :email, :amount)
    end

    def credit_card_params
      { number: params[:number], cvv: params[:cvv], expiration_date: expiration_date_param }
    end

    def expiration_date_param
      "#{params[:donation]['expiration_date(2i)']}/#{params[:donation]['expiration_date(1i)']}"
    end
end
