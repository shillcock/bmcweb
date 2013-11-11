class IntroMeeting < ActiveRecord::Base
  structure do
    title       :string,   "Free Intro Meeting", validates: :presence
    starts_at   :datetime, Time.now,             validates: :presence
    ends_at     :datetime, Time.now + 4.hours,   validates: :presence
    description :text,     "Free meeting open to everyone."
    timestamps
  end

  def self.upcomming(limit=3)
    where('starts_at >= ?', Time.now).order(:starts_at).limit(limit)
  end
end
