class DonationsController < ApplicationController
  skip_before_action :authorize, only: [:new, :iframe, :create]
  before_action :set_donation, only: [:show, :destroy]

  def index
    @donation = Donation.all
  end

  def new
    @donation = Donation.new
  end

  def iframe
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)

    if process_donation
      redirect_to root_path, notice: "Thank you for your donation."
    else
      render :new
    end
  end

  def show
  end

  def destory
    @donation.destory
    redirect_to donations_url, notice: 'Donation was successfully deleted.'
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(:name, :email, :comment, :amount, :stripe_token)
    end

    def strip_iframe_protection
      response.headers.delete('X-Frame-Options')
    end

    def process_donation
      return false unless @donation.valid?
      DonationProcessor.new(@donation).process
    end
end
