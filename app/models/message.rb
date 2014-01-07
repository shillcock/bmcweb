class Message
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attribute :name, String
  attribute :email, String
  attribute :message, String
  attribute :remote_ip, String
  attribute :user_agent, String

  validates :name, presence: true
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }
  validates :message, presence: true

  def process
    valid? ? ContactMailer.new_message(self).deliver : false
  end

  private
    def persisted?
      false
    end
end
