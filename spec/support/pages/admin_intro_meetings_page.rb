class AdminIntroMeetingsPage
  include Capybara::DSL

  def initialize user
    @user = user
  end

  def visit_page
    visit "/admin/intro_meetings"
  end

  def navigate_to_page
    visit root_path(as: @user)
    nav_menu.click_link("Admin")
    nav_menu.click_link('Intro Meetings')
    click_link 'New Intro Meeting'
  end

  def complete_form(meeting_date)
    select_date meeting_date, from: 'intro_meeting_date'
    select_time Time.parse("19:00"), from: 'intro_meeting_starts_at'
    select_time Time.parse("21:00"), from: 'intro_meeting_ends_at'
  end

  def submit
    click_button 'Create Intro meeting'
  end

  def successful?
    page.has_content?("Intro meeting has been created for #{meeting_date}")
  end

  private
    def nav_menu
      find('header nav')
    end
end
