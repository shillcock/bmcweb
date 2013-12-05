require 'spec_helper'

feature "Donating money to Breakthrough" do
  before do
    visit root_path
    click_link "Donate"
  end

  scenario "Visitor can donate money", js: true do
    fill_in "First name", with: "Jon"
    fill_in "Last name", with: "Snow"
    fill_in "Email", with: "jonsnow@example.com"
    fill_in "Amount", with: "150.00"

    fill_in "Number", with: "4111111111111111"
    fill_in "CVV", with: "123"

    click_button "Create Donation"

    expect(page).to have_content("Thank you for your donation.")
  end
end
