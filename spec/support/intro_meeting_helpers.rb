module IntroMeetingHelpers
  def create_intro_meeting_in days
    start_time = Time.now + days
    create_intro_meeting_at start_time
  end

  def create_intro_meeting_at start_time
    create(:intro_meeting, starts_at: start_time, ends_at: start_time + 4.hours)
  end
end

RSpec.configure do |config|
  config.include IntroMeetingHelpers
end
