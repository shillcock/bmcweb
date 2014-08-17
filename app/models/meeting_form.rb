class MeetingForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Virtus.model

  attribute :meeting_id, Integer
  attribute :title, String
  attribute :date, String

  validates_presence_of :title
  validates_presence_of :date

  attr_reader :meeting

  def initialize(params)
    @workshop = params[:workshop]
    @meeting = params[:meeting]

    if @meeting
      params[:title] = @meeting.title unless params[:title]
      params[:date] = "#{@meeting.starts_at} - #{@meeting.ends_at}" unless params[:date]
    else
      prev_meeting = @workshop.meetings.last
      if prev_meeting && params[:date].blank?
        prev_start = prev_meeting.starts_at + 1.week
        prev_end = prev_meeting.ends_at + 1.week
        params[:date] = "#{prev_start} - #{prev_end}"
      end
    end

    super params
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

    def persist!
      ActiveRecord::Base.transaction do
        if @meeting
          @meeting.attributes = meeting_params
        else
          @meeting = @workshop.meetings.build(meeting_params)
        end

        @meeting.save!
      end
    end

    def meeting_params
      {
        title: title,
        starts_at: starts_at,
        ends_at: ends_at
      }
    end

    def starts_at
      Time.zone.parse(date_range.first)
    end

    def ends_at
      Time.zone.parse(date_range.last)
    end

    def date_range
      date.split(" - ")
    end
end
