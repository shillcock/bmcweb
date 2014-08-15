# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create name: "admin", email: "admin@bmc.link", password: ENV["BASIC_AUTH_PASSWORD"], admin: true

start_date = DateTime.new(2015, 2, 4)

d = start_date
w = Workshop.create name:"BT1", title: "Breakthrough 1", description: "Thursday"

create_meeting(w, "Introductions, Key Topics and Expectations", d)
create_meeting(w, "Basic Assumptions, Feelings and Truth Telling", d+1.week)
create_meeting(w, "Listening and Self-esteem", d+2.week)
create_meeting(w, "Separating Esteeming Ourselves from Feelings", d+3.week)
create_meeting(w, "Overview of Communication Skills and External Boundaries", d+4.week)
create_meeting(w, "Day Long - Assessing Our Boundary System and Accountability", d+5.week)
create_meeting(w, "Anger, Abuse and Addressing Intense Feelings Respectfully", d+6.week)
create_meeting(w, "The Natural Healing Process, Coping and Addictions", d+7.week)
create_meeting(w, "Men and the Healing Process", d+8.week)
create_meeting(w, "Parenting Styles that Help and Hurt Children", d+9.week)
create_meeting(w, "Day Long – Our Reality at Age 7 and Five Feeling States", d+10.week)

# w = Workshop.create name:"BT2", title: "Breakthrough 2"

# dd = start_date
# m1 = w.meetings.create({
#   meeting_number: 1,
#   title: "Meeting 1",
#   starts_at: DateTime.new(dd.year, dd.month, dd.day, 18, 30),
#   ends_at: DateTime.new(dd.year, dd.month, dd.day, 21, 30)
# })

# self.created_on.strftime("%B %d, %Y")

def create_meeting(workshop, title, date)
  workshop.meetings.create({
    title: title,
    starts_at: DateTime.new(date.year, date.month, date.day, 18, 30),
    ends_at: DateTime.new(date.year, date.month, date.day, 21, 30)
  })
end
