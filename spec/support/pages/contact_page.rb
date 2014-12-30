require 'capybara/rspec'

class ContactPage
  include Capybara::DSL

  def visit_page
    visit '/contact'
  end

  def complete_form
    fill_in 'Name', with: 'Joe Smith'
    fill_in 'Email', with: 'example@exampe.com'
    fill_in 'Message', with: 'Just wanted to say keep up the good work.'
  end

  def submit
    click_button 'Send Message'
  end

  def successful?
    page.current_path == '/contact' && page.has_content?('got it!')
  end
end
