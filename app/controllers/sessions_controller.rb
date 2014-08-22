class SessionsController < Clearance::SessionsController
  protected

    def url_after_create
      if current_user_is_admin?
        admin_root_path
      else
        my_profile_path
      end
    end

    def url_after_destroy
      root_path
    end
end
