class DonatePage
  include Capybara::DSL

  def visit_page
    visit "/donate"
  end

  def navigate_to_page
    visit root_path
    click_link "Donate"
  end

  def complete_form
    # fill_in "Name", with: "Jon Snow"
    fill_in "Email", with: "jonsnow@example.com"
    fill_in "Amount", with: "150"

    fill_in "Number", with: "4242424242424242"
    fill_in "CVC", with: "111"

    # select_date meeting_date, from: "intro_meeting_date"
    select Date.today.year+1, :from => "card-year"
  end

  def submit
    click_button "Send Donation"
  end

  def successful?
    # page.current_path == '/donate' &&
    page.has_content?("Thank you for your donation.")
  end
end
