class ContactController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def create
    if message.process
      flash[:notice] = "Ok, we've got it! We will get in touch with you shortly."
      @message = Message.new
      redirect_to contact_path
    else
      flash[:alert] = "Unable to send your message."
      render :new
    end
  end

  private
    def message
      @message ||= Message.new(params[:message] || {})
      @message.remote_ip = request.remote_ip
      @message.user_agent = request.user_agent
      @message
    end
    helper_method :message
end
