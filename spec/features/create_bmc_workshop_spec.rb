require 'spec_helper'

feature 'Creating Bmc::Workshop as an Admin' do
  let(:admin) { create(:admin) }
  let(:workshop) { create(:workshop) }

  scenario 'Creating a workshop' do
    visit root_path(as: admin)
    header_nav.click_link('Admin')
    header_nav.click_link('Workshops')
    click_link 'New Workshop'

    fill_in 'Title', with: workshop.title
    click_button 'Create Workshop'

    expect(page).to have_content("Workshop has been created")
  end
end
