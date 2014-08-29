class Payment < ActiveRecord::Base
  belongs_to :user
  monetize :amount_cents
  validates_uniqueness_of :guid
  before_save :populate_guid

  def to_param
    guid
  end

  private

    def populate_guid
      if new_record?
        while !valid? || self.guid.nil?
          self.guid = [Date.current.year, SecureRandom.random_number(1_000_000_000).to_s(32)].join('-')
        end
      end
    end
end
