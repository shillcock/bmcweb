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
    @bt1 ||= begin Workshop.find(1) rescue NullWorkshop.new end
  end

  def bt2
    @bt2 ||= begin Workshop.find(2) rescue NullWorkshop.new end
  end

  private

    class NullWorkshop
      def title; ""; end
      def sections; []; end
    end
end
