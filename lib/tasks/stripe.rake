namespace :stripe do
  desc 'Sync creadit cards from stripe to User model'
  task :sync_credit_cards => :environment do
    User.all.find_each do |user|

      UpdateUsersDefaultCreditCard.perform_async(user.id)

      # if user.stripe_customer_id
      #   customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      #   card = customer.cards.retrieve(customer.default_card) if customer and customer.default_card
      #   user.update_credit_card(card)
      # end
    end
  end

  desc 'Notifies customers that their credit card is about to expire'
  task :card_exipration_notice => :environment do
    exception_notify do
      # CardExpirer.perform_async(Date.current.next_month)
    end
  end
end
