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
  has_many :lessons, dependent: :destroy
  has_many :sections, dependent: :destroy

  scope :bt1, -> { find(1) }
  scope :bt2, -> { find(2) }

  def short_name
    "BT#{id}"
  end

  def bt1?
    id == 1
  end

  def bt2?
    id == 2
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
