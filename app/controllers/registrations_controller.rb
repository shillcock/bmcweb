class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_workshop

  def new
    @registration = RegistrationForm.new(workshop: @workshop, user: current_user)
  end

  def create
    @registration = RegistrationForm.new(registration_params.merge(workshop: @workshop, user: current_user))

    if @registration.valid?
      @registration.save
      flash[:notice] = "Thanks for registering."
      redirect_to [:my, :profile]
    else
      render :new
    end
  end

  private

    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

  def registration_params
    params.require(:registration_form).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :address1,
        :address2,
        :city,
        :state,
        :zip_code,
        :phone_number,
        :birthday)
  end
end
