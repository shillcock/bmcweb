require 'spec_helper'

feature 'Creating New Section' do
  let(:admin) { create(:admin) }
  let!(:workshop) { create(:workshop) }
  let!(:lesson) { create(:lesson, workshop: workshop)}

  scenario 'From workshop' do
    visit root_path(as: admin)
    click_link('Admin')
    click_link('Workshops')
    click_link workshop.title

    fill_in "Title", with: "New Test Section"
    fill_in "Start date", with: 1.week.from_now
    click_button 'Create Section'

    expect(page).to have_content("Section has been created")
  end
end
