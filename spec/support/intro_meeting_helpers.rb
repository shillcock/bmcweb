module IntroMeetingHelpers
  def create_intro_meeting_on date
    create(:intro_meeting, date: date.to_date)
  end
end

RSpec.configure do |config|
  config.include IntroMeetingHelpers
end
