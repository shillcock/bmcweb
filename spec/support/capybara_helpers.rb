module CapybaraHelpers
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", :text => text), "Expected not to see the #{text.inspect} link, but did.")
  end

  def assert_link_for(text)
    expect(page).to(have_css("a", :text => text), "Expected to see the #{text.inspect} link, but did not.")
  end

  # def select_by_id(id, options = {})
  #   field = options[:from]
  #   option_xpath = "//*[@id='#{field}']/option[#{id}]"
  #   option_text = find(:xpath, option_xpath).text
  #   select option_text, :from => field
  # end

  def select_date(date, options = {})
    field = options[:from]
    select date.year.to_s,      :from => "#{field}_1i"
    select date.strftime('%B'), :from => "#{field}_2i"
    select date.day.to_s,       :from => "#{field}_3i"
  end

  def select_time(time, options = {})
    field = options[:from]
    select time.hour.to_s.rjust(2, '0'), :from => "#{field}_4i"
    select time.min.to_s.rjust(2, '0'),  :from => "#{field}_5i"
  end

  def header_nav
    find('header nav')
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, type: :feature
end
