class SubscribeToNewsletter
  include Sidekiq::Worker

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      find_user(user_id)
      subscribe_to_list
      update_user
    end
  end

  private

    def find_user(user_id)
      @user = User.find(user_id)
    end

    def update_user
      mailchimp_list_id = @subscription["leid"]
      @subscription
    end

    def subscribe_to_list
      @subscription = api.lists.subscribe(
        id: list_id,
        update_existing: true,
        double_optin: false,
        email: { email: @user.email },
        merge_vars: {
          FNAME: @user.first_name,
          LNAME: @user.last_name,
          BDAY: @user.birthday.present? ? @user.birthday.strftime("%m/%d") : ""
        }
      )
    end

    def list_id
      Rails.configuration.mailchimp[:bmc_list_id]
    end

    def api
      @api ||= Gibbon::API.new
    end
end
