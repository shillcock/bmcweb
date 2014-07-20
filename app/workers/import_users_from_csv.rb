require 'csv'
require 'securerandom'

class ImportUsersFromCsv
  include Sidekiq::Worker

  def perform(file)
    ActiveRecord::Base.connection_pool.with_connection do
      CSV.foreach(file, headers: true) do |row|
        build_user(row)
        generate_random_password
        save_user
      end
    end
  end

  private
    def build_user(row)
      params = user_params(row)
      @user = User.new(params)
    end

    def save_user
      if @user.save
        pp "User saved - #{@user.id} - #{@user.name}!!!!"
        CreateStripeCustomer.perform_async(@user.id)
      else
        pp "User invalid: #{@user.errors}"
      end
    end

    def user_params(row)
      {
        name: [row["First Name"], row["Last Name"]].join(' '),
        email: row["Email"],
        phone_number: row["Phone"],
        address1: row["Address"],
        city: row["City"],
        state: row["State"],
        zip_code: row["Zip"],
        birthday: row["Birthday"],
      }
    end

    def other_params
      #@row.to_hash
    end

    def generate_random_password
      @user.password = SecureRandom.hex(10)
    end
end
