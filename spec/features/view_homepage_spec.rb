feature 'View the homepage' do
  scenario 'user sees welcome page information' do
    visit root_path
    expect(page).to have_title "Breakthrough Men's Community"
  end

  scenario 'user sees a list of upcoming free introductory meetings' do
    first_of_november = Time.zone.parse "November 1st, 2013 16:00"
    Timecop.freeze first_of_november do
      [-2.weeks, -1.week, 1.week, 2.weeks, 3.weeks].each do |days|
        create_intro_meeting_on first_of_november + days
      end

      visit root_path
      expect(page).to have_content 'Upcoming Free Introductory Meetings'
      expect(page).to have_selector 'table#intro-meetings tr', count: 4 # 1 heading row + 3 meetings rows

      [1.week, 2.weeks, 3.weeks].each do |days|
        expect(page).to have_content (first_of_november + days).strftime("%A, %B %e, %Y")
      end
    end
  end
end
