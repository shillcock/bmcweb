class MyController < ApplicationController
  def index
    redirect_to my_profile_path
  end
end
