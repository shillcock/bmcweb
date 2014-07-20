# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  admin              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  include Clearance::User

  has_one :alumni_membership, dependent: :destroy

  has_many :section_enrollments, dependent: :destroy
  has_many :sections, through: :section_enrollments
  # has_many :bt1_sections, source: :section, through: :section_enrollments, -> {}

  validates :name, presence: true

  scope :students, -> { joins(:section_enrollments).merge(SectionEnrollment.students) }
  scope :educators, -> { joins(:section_enrollments).merge(SectionEnrollment.educators) }

  # scope :the_students, -> { where()}

  scope :bt1, -> { joins(:sections).merge(Section.bt1) }
  scope :bt2, -> { joins(:sections).merge(Section.bt2) }

  # after_save :create_stripe_customer, on: :create
  # before_destroy :delete_stripe_customer

  def first_name
    name.split(" ").first
  end

  def last_name
    name.split(" ").last
  end

  def alumni?
    alumni_membership.present? and alumni_membership.active?
  end

  def enrolled?(section)
    sections.include?(section) if section
  end

  def bt1
    sections.bt1.last
  end

  def bt2
    sections.bt2.last
  end

  private

    # def create_stripe_customer
    #  CreateStripeCustomer.perform_async(self.id)
    # end

    # def delete_stripe_customer
    #  DeleteStripeCustomer.perform_async(stripe_customer_id) if stripe_customer_id.present?
    # end
end
