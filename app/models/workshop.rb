# == Schema Information
#
# Table name: workshops
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Workshop < ActiveRecord::Base

  BASE_TITLE="Breakthrough"
  BT1_TITLE="#{BASE_TITLE} 1"
  BT2_TITLE="#{BASE_TITLE} 2"

  has_many :lessons, dependent: :destroy
  has_many :sections, dependent: :destroy

  scope :bt1, -> { where(title: Workshop::BT1_TITLE) }
  scope :bt2, -> { where(title: Workshop::BT2_TITLE) }

  def short_name
    title.sub(Workshop::BASE_TITLE, "BT").delete(" ")
  end

  def bt1?
    title == Workshop::BT1_TITLE
  end

  def bt2?
    title == Workshop::BT2_TITLE
  end

  def active_sections
    sections.where(active: true).order(:date)
  end

  def upcoming_sections
    sections.where('date >= ?', Time.zone.today).order(:date)
  end

  def past_sections
    sections.where('date <= ?', Time.zone.today).order(:date)
  end
end
