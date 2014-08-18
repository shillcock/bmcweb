namespace :bmc do
  desc 'Creates workshop data'
  task setup: :environment do
    # 2014
    # 1 - July 24
    # 2 - October 30
    # 2015
    # 1 - February 4
    # 2 - May 20
    # 1 - May 26
    # 2 - September 8

    # Build Workshops
    Workshop.destroy_all

    build_bt1_workshop(Date.new(2014, 7, 24))
    build_bt2_workshop(Date.new(2014, 10, 30))

    build_bt1_workshop(Date.new(2015, 2, 4))
    build_bt2_workshop(Date.new(2015, 5, 20))

    build_bt1_workshop(Date.new(2015, 5, 26))
    build_bt2_workshop(Date.new(2015, 9, 8))

    # Build Intro Meetings
    IntroMeeting.destroy_all

    build_intro_meeting(Date.new(2014, 6, 19))
    build_intro_meeting(Date.new(2014, 7, 3))
    build_intro_meeting(Date.new(2014, 7, 17))

    build_intro_meeting(Date.new(2015, 1, 7))
    build_intro_meeting(Date.new(2015, 1, 14))
    build_intro_meeting(Date.new(2015, 1, 28))
    build_intro_meeting(Date.new(2015, 4, 21))
    build_intro_meeting(Date.new(2015, 5, 5))
    build_intro_meeting(Date.new(2015, 5, 19))

  end

  def create_meeting(workshop, title, date)
    MeetingForm.new(workshop: workshop, title: title, date: "#{date.to_s} 6:30 PM - #{date.to_s} 10:00 PM").save
    # m = workshop.meetings.create({
    #   title: title,
    #   starts_at: "#{date.to_s} 6:30 PM",
    #   ends_at: "#{date.to_s} 10:00 PM"
    # })
  end

  def build_intro_meeting(d)
    m = IntroMeeting.create({
      date: d.to_s,
      starts_at: "7:00 PM",
      ends_at: "9:00 PM"
    })
    pp "Created: intro meeting on #{m.date}"
  end

  def build_bt1_workshop(d)
    w = Workshop.create name:"BT1", title: "Breakthrough 1"
    create_meeting(w, "Introductions, Key Topics and Expectations", d)
    create_meeting(w, "Basic Assumptions, Feelings and Truth Telling", d+1.week)
    create_meeting(w, "Listening and Self-esteem", d+2.weeks)
    create_meeting(w, "Separating Esteeming Ourselves from Feelings", d+3.weeks)
    create_meeting(w, "Overview of Communication Skills and External Boundaries", d+4.weeks)
    create_meeting(w, "Day Long - Assessing Our Boundary System and Accountability", d+5.weeks)
    create_meeting(w, "Anger, Abuse and Addressing Intense Feelings Respectfully", d+6.weeks)
    create_meeting(w, "The Natural Healing Process, Coping and Addictions", d+7.weeks)
    create_meeting(w, "Men and the Healing Process", d+8.weeks)
    create_meeting(w, "Parenting Styles that Help and Hurt Children", d+9.weeks)
    create_meeting(w, "Day Long – Our Reality at Age 7 and Five Feeling States", d+10.weeks)
    create_meeting(w, "Boyhood Traumas and Shame", d+11.weeks)
    create_meeting(w, "Complete Personal History", d+12.weeks)
    create_meeting(w, "weeksend - Separating Adult, Child and Carried Feelings Using our Histories", d+13.weeks)
    create_meeting(w, "Follow-up Guidelines, Reparenting and Overview of BT2", d+14.weeks)
    create_meeting(w, "More Work on Histories with Emphasis on Public Humiliation", d+15.weeks)
    create_meeting(w, "BT 1 Completion Celebration", d+16.weeks)
    pp "Created: #{w.name} - #{w.title} - #{w.start_date} - #{w.end_date}"
  end

  def build_bt2_workshop(d)
    w = Workshop.create name:"BT2", title: "Breakthrough 2"
    create_meeting(w, "Concept of Inherent Nature", d)
    create_meeting(w, "Remembering Our Goodness", d+1.week)
    create_meeting(w, "The Power of Accountability", d+2.weeks)
    create_meeting(w, "The Power of Accountability 2", d+3.weeks)
    create_meeting(w, "False Beliefs", d+4.weeks)
    create_meeting(w, "False Beliefs (Part 2)", d+5.weeks)
    create_meeting(w, "Review Key Practices", d+6.weeks)
    create_meeting(w, "Entering our Heroic Journey (Part 1)", d+7.weeks)
    create_meeting(w, "Entering our Heroic Journey (Part 2)", d+8.weeks)
    create_meeting(w, "Introduction of Our Work on Love and Relationships: The Human Body, Intimacy and Sex'", d+9.weeks)
    create_meeting(w, "Introduction of Our Work on Love and Relationships: The Human Body, Intimacy and Sex'", d+10.weeks)
    create_meeting(w, "The Male Role & Male-Role Sex'", d+11.weeks)
    create_meeting(w, "Love and Relationships 4: Fantasies, Fears, Sex and Love'", d+12.weeks)
    create_meeting(w, "Love and Relationships 5: Next steps for me'", d+13.weeks)
    create_meeting(w, "Review of Basics and Processing Session Time'", d+14.weeks)
    create_meeting(w, "Resources for Ongoing Support and The BT3 Class'", d+15.weeks)
    create_meeting(w, "Welcome to BMC celebration'", d+16.weeks)
    pp "Created: #{w.name} - #{w.title} - #{w.start_date} - #{w.end_date}"
  end
end
