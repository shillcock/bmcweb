require 'spec_helper'

feature 'Contact Us' do
  let(:contact_page) { ContactPage.new }

  scenario 'via the landing page' do
    contact_page.visit_page
    contact_page.complete_form
    contact_page.submit
    contact_page.should be_successful

    ActionMailer::Base.deliveries.should_not be_empty
    result = ActionMailer::Base.deliveries.select do |email|
      email.subject =~ /Contact/i && email.body =~ /keep up the good work/
    end
    result.should have_at_least(1).item
  end
end
