class Participant
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :user, :section

  delegate :id, :name, :email, :phone_number, :birthday, to: :user

  def initialize(user, section)
    @user = user
    @section = section
  end

  def enrolled?
    user.enrolled?(section)
  end

  def enroll(role: "student")
    return false if enrolled?
    new_enrollment = SectionEnrollment.new(user_id: user.id, section_id: section.id)
    new_enrollment.add_role(role)
    new_enrollment.save
  end

  def drop_out
    return unless enrolled?
    section.enrollments.delete(user)
  end

  def student?
    has_role?(:student)
  end

  def educator?
    has_role?(:educator)
  end

  def persisted?
    false
  end

  def self.name
    "User"
  end

  private

    def has_role?(role)
      enrollment.has_role?(role) if enrolled?
    end

    def enrollment
      @enrollment ||= section.section_enrollments.find_by(user_id: user.id, section_id: section.id)
    end
end
