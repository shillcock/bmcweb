namespace :bmc do
  desc 'Creates workshop data'
  task setup: :environment do

    require 'yaml'
    #require 'pry'

    config = YAML.load_file("lib/tasks/bmc.yml")

    config.each do |data|
      create_workshops data
    end
  end

  def create_workshops data
    header "Workshops"

    workshop = Workshop.create! data[:workshop]
    puts "#{workshop.id} - #{workshop.title}"

    create_lessons workshop, data[:lessons]
  end

  def create_lessons workshop, lessons
    header "#{workshop.title} Lessons"

    lessons.each do |params|
      lesson = workshop.lessons.create! params
      puts "#{lesson.id} - #{lesson.title} [#{lesson.lesson_number}]"
    end

    puts "#{workshop.lessons.count} lessons created"
  end

  def header(msg)
    puts "\n*** #{msg.upcase} *** \n"
  end
end
