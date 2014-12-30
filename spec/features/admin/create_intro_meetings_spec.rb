feature 'Creating IntroMeetings as an Admin' do
  let(:admin) { create(:admin) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path
    click_link "Admin"
  end

  scenario 'Creating an intro meeting' do
    click_link 'Intro Meetings'
    click_link 'Add new meeting'

    fill_in "Date", with: meeting_date
    fill_in "Starts at" , with: "7:00 PM"
    fill_in "Ends at" , with: "9:00 PM"

    click_button 'Create Intro meeting'

    expect(page).to have_content("Intro meeting has been created for #{meeting_date}")
  end

  def meeting_date
    @mdate ||= 2.days.from_now.to_date
  end
end
