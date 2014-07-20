class Message < PlainModel

  attribute :name, String
  attribute :email, String
  attribute :message, String

  validates :name, presence: true
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }
  validates :message, presence: true

  set_callback :save, :after, :send_message

  private

    def send_message
      ContactMailer.new_message(self).deliver
    end
end
