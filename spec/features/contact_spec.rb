require 'spec_helper'

feature 'Contact Us' do
  let(:contact_page) { ContactPage.new }

  scenario 'via the landing page' do
    contact_page.visit_page
    contact_page.complete_form
    contact_page.submit
    expect(contact_page).to be_successful

    expect(ActionMailer::Base.deliveries).to_not be_empty
    result = ActionMailer::Base.deliveries.select do |email|
      expect(email.subject).to match(/Contact/i)
      expect(email.body).to match(/keep up the good work/)
    end

    expect(result.size).to be >= 1
  end
end
