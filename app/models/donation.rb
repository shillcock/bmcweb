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

  attr_reader :transaction_id, :error

  def persisted?
    false
  end

  def finished?
    @finished
  end

  def process_payment!
    charge_card if valid?
  end

  private

    def charge_card
      @result = Braintree::Transaction.sale(
        amount: self.amount,
        credit_card: credit_card,
        customer: customer,
        options: { submit_for_settlement: true }
      )

      if @result.success?
        @transaction_id = @result.transaction.id
        @finished = true
      else
        copy_errors_from_result
        @error = @result.message
        @finished = false
      end


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

    def copy_errors_from_result
      @result.errors.each do |e|
        errors.add(e.attribute, e.message)
      end
    end
end

def dddd
d = Donation.new({:first_name=>"scott",
 :last_name=>"shillcock",
 :email=>"me@scott.sh",
 :amount=>99,
 :credit_card=>
  {:number=>"4411111111111111",
   :cvv=>123,
   :expiration_month=>11,
   :expiration_year=>2015}})
end
