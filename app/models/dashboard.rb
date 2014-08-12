class Dashboard
  def initialize
  end

  def alumni_membership_count
    AlumniMembership.active.count
  end

  def user_count
    User.all.count
  end
end
