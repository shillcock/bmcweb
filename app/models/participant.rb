class Participant
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :user, :workshop

  delegate :id, :name, :email, :phone_number, to: :user

  def initialize(user, workshop)
    @user = user
    @workshop = workshop
  end

  def enrolled?
    user.enrolled?(workshop)
  end

  # def enroll(role: :student)
  #   return false if enrolled?
  #   new_enrollment = WorkshopEnrollment.new(user_id: user.id, workshop_id: workshop.id, role: role)
  #   new_enrollment.save
  # end

  # def drop_out
  #   return unless enrolled?
  #   workshop.enrollments.delete(user)
  # end

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

  def enrollment
    @enrollment ||= workshop.workshop_enrollments.find_by(user_id: user.id)
    @enrollment ||= NullEnrollment.new
  end

  private

    class NullEnrollment
      def student?; false; end
      def educator?; false; end
    end
end
