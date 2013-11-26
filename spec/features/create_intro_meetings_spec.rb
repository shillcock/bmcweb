require 'spec_helper'

feature 'Creating IntroMeetings' do
  scenario 'Creating an intro meeting' do
    admin = create(:admin)
    visit admin_root_path(as: admin)
    click_link 'New Intro Meeting'

    select_date meeting_date, from: "intro_meeting_date"
    select_time Time.parse("19:00"), from: "intro_meeting_starts_at"
    select_time Time.parse("21:00"), from: "intro_meeting_ends_at"

    click_button 'Create Intro meeting'

    expect(page).to have_content("Intro Meeting has been created for #{meeting_date}")
  end

  def meeting_date
    @mdate ||= 2.days.from_now.to_date
  end
end
