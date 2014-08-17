class WorkshopSection
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Virtus.model

  attr_reader :section

  attribute :title, String
  attribute :start_date, Date

  validates_presence_of :title
  validates_presence_of :start_date

  def initialize(workshop, params)
    @workshop = workshop
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
        build_section
        build_meetings
      end
    end

    def build_section
      @section = @workshop.sections.create!(title: title)
    end

    def build_meetings
      lessons.each do |lesson|
        build_meeting(lesson)
      end
    end

    def build_meeting lesson
      dd = default_date(lesson)
      @section.meetings.create!(
        lesson: lesson,
        starts_at: DateTime.new(dd.year, dd.month, dd.day, 18, 30),
        ends_at: DateTime.new(dd.year, dd.month, dd.day, 21, 30)
      )
    end

    def lessons
      @workshop.lessons.order(:lesson_number).each
    end

    def default_date(lesson)
      start_date + (lesson.lesson_number - 1).weeks
    end
end
