class DeleteStripeCustomer
  include Sidekiq::Worker

  def perform(customer_id)
    customer = Stripe::Customer.retrieve(customer_id)
    customer.delete
  end
end
