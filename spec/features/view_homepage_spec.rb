require 'spec_helper'

feature 'View the homepage' do
  scenario 'user sees welcome page information' do
    visit root_path
    expect(page).to have_title "Breakthrough Men's Community"
    expect(page).to have_selector '[data-role="description"]'
  end

  scenario 'user sees a list of upcomming free introductory meetings' do
    first_of_november = Time.parse "November 1st, 2013 16:00"
    Timecop.freeze first_of_november do

      [1.week, 2.week, 3.week].each do |value|
        start_time = first_of_november + value
        end_time = start_time + 4.hours
        create(:intro_meeting, starts_at: start_time, ends_at: end_time)
      end

      visit root_path
      expect(page).to have_content 'Upcoming Free Introductory Meetings'
      expect(page).to have_selector 'li.intro_meeting', count: 3

      [1.week, 2.week, 3.week].each do |value|
        expect(page).to have_content (first_of_november + value).to_date
      end
    end
  end
end
