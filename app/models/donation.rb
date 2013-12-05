class Donation
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :first_name, String
  attribute :last_name, String
  attribute :email, String
  attribute :amount, Decimal
  attribute :number, String
  attribute :cvv, String
  attribute :expiration_date, Date

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :amount, presence: true
  validates :number, presence: true
  validates :cvv, presence: true
  validates :expiration_date, presence: true

  attr_reader :transaction_id

  def persisted?
    false
  end

  def finished?
    @finished
  end

  def process_payment!
    charge_card if valid?
    self.attributes = { number: nil, cvv: nil }
  end

  private

    def charge_card
      result = Braintree::Transaction.sale(
        amount: self.amount,
        credit_card: credit_card,
        customer: customer,
        options: { submit_for_settlement: true }
      )

      @finished = handle_result(result)
    end

    def credit_card
      {
        number: self.number,
        cvv: self.cvv,
        expiration_date: self.expiration_date.strftime("%m/%Y")
      }
    end

    def customer
      {
        first_name: self.first_name,
        last_name: self.last_name,
        email: self.email
      }
    end

    def handle_result(result)
      if result.success?
        @transaction_id = result.transaction.id
        @transaction = result.transaction
        true
      else
        handle_result_transaction(result.transaction)
        handle_result_errors(result.errors)
        false
      end
    end

    def handle_result_transaction(transaction)
      if transaction.respond_to?(:status)
        case transaction.status
        when "failed"
          errors.add :number, "transaction failed: #{transaction.processor_response_text}"
        when "processor_declined"
          errors.add :number, "was denied by the payment processor with the message: #{transaction.processor_response_text}"
        when "gateway_rejected"
          errors.add :cvv, "did not match"
        end
      end
    end

    def handle_result_errors(remote_errors)
      remote_errors.each do |error|
        errors.add error.attribute, error.message
      end
    end
end
