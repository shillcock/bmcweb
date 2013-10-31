require 'spec_helper'

feature 'View the homepage' do
  scenario 'user sees welcome page information' do
    visit root_path
    expect(page).to have_title "Breakthrough Men's Community"
    expect(page).to have_selector '[data-role="description"]'
  end
end
