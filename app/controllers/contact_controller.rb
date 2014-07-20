class ContactController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    build_message
  end

  def create
    build_message
    if @message.save
      flash[:notice] = "Ok, we've got it! We will get in touch with you shortly."
      redirect_to contact_path
    else
      flash[:alert] = "Unable to send your message."
      render :new
    end
  end

  private
    def build_message
      @message ||= Message.new(params[:message])
    end
end
