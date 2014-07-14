class Dashboard
  def initialize
  end

  def alumni_membership_count
    AlumniMembership.active.count
  end

  def user_count
    User.all.count
  end

  def bt1
    @bt1 ||= Workshop.find(1)
  end

  def bt2
    @bt2 ||= Workshop.find(2)
  end
end
