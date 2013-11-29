class DonationsController < ApplicationController
  def new
  end

  def create
    result = Braintree::Transaction.sale(
      :amount => params[:donation][:amount],
      :credit_card => {
        :number => params[:number],
        :cvv => params[:cvv],
        :expiration_month => params[:month],
        :expiration_year => params[:year]
      },
      :customer => {
        :first_name => params[:donation][:first_name],
        :last_name => params[:donation][:last_name],
        :email => params[:donation][:email]
      },
      :options => {
        :submit_for_settlement => true
      }
    )

binding.pry

    if result.success?
      flash[:notice] = "Success! Transaction ID: #{result.transaction.id}"
      redirect_to root_path
    else
      flash[:alert] = result.message
      render :new
    end
  end
end
