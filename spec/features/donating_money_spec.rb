require 'spec_helper'

feature "Donating money to Breakthrough" do
  before do
    @original_wait_time = Capybara.default_wait_time
    Capybara.default_wait_time = 12
    # visit root_path
    # click_link "Donate"
  end
  after { Capybara.default_wait_time = @original_wait_time }

  let(:donate_page) { DonatePage.new }

  #xscenario "via the landing page", js: true do
  #  # donate_page = DonatePage.new
  #
  #  donate_page.visit_page
  #  donate_page.complete_form
  #  donate_page.submit
  #  expect(donate_page).to be_successful
  #end

  # scenario "Visitor can donate money", js: true do
  #   # fill_in "First name", with: "Jon"
  #   # fill_in "Last name", with: "Snow"
  #   fill_in "Email", with: "jonsnow@example.com"
  #   fill_in "Amount", with: "150.00"

  #   fill_in "Number", with: "4111111111111111"
  #   fill_in "CVC", with: "123"

  #   click_button "Send Donation"

  #   expect(page).to have_content("Thank you for your donation.")
  # end
end
