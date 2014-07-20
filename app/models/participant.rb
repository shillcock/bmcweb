class Participant
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :user, :section

  class NullEnrollment
    def student?; false; end
    def educator?; false; end
  end

  delegate :id, :name, :email, :phone_number, to: :user

  def initialize(user, section)
    @user = user
    @section = section
  end

  def enrolled?
    user.enrolled?(section)
  end

  def enroll(role: :student)
    return false if enrolled?
    new_enrollment = SectionEnrollment.new(user_id: user.id, section_id: section.id, role: role)
    new_enrollment.save
  end

  def drop_out
    return unless enrolled?
    section.enrollments.delete(user)
  end

  def student?
    enrollment.student?
  end

  def educator?
    enrollment.educator?
  end

  def birthday
    user.birthday.strftime("%B %e") if user.birthday?
  end

  def persisted?
    false
  end

  def self.name
    "User"
  end

  private

    def enrollment
      @enrollment ||= section.section_enrollments.find_by(user_id: user.id, section_id: section.id) :: NullEnrollment.new
    end
end
