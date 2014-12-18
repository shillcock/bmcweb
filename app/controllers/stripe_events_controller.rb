class StripeEventsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> (c) { c.request.format == "application/json" }
  skip_before_action :authenticate_user!, only: [:create]
  before_action :parse_and_validate_event

  def create
    if event_method_defined?
      self.send(event_method, @event.event_object)
    end

    render nothing: true
  end

  private

    def parse_and_validate_event
      @event = StripeEvent.new(stripe_id: params[:id], stripe_type: params[:type])

      unless @event.save
        if @event.valid?
          render nothing: true, status: 400 # valid event, try again later
        else
          render nothing: true # invalid event, move along
        end
      end
    end

    def event_method_defined?
      self.class.private_method_defined? event_method
    end

    def event_method
      "stripe_#{event_type}".to_sym
    end

    def event_type
      @event.stripe_type.gsub('.', '_')
    end

    def stripe_charge_dispute_created(charge)
      # AccountMailer.admin_dispute_created(charge).deliver
    end

    def stripe_charge_succeeded(charge)
      if user = User.find_by(stripe_customer_id: charge.customer)
        payment = user.payments.find_or_create_by(stripe_charge_id: charge.id)
        payment.update_from_stripe_charge(charge)
      end
    end

    def stripe_invoice_payment_failed(invoice)
      if user = User.find_by(stripe_customer_id: invoice.customer)
        # AccountMailer.payment_failed(user, invoice)
      end
    end

    def stripe_customer_updated(customer)
      if user = User.find_by(stripe_customer_id: customer.id)
        card = customer.cards.retrieve(customer.default_card)
        user.update_from_stripe_card(card)
      end
    end

    def stripe_customer_subscription_deleted(subscription)
      if user = User.find_by(stripe_customer_id: subscription.customer)
        if user.alumni_membership
          user.alumni_membership.update(
            deactivated_on: Time.zone.today,
            stripe_subscription_id: nil,
            status: "canceled")
        end
      end
    end

    def stripe_customer_deleted(customer)
      if user = User.find_by(stripe_customer_id: customer.id)
        user.update(stripe_customer_id: nil)
      end
    end
end
