module ApplicationHelper
  def nav_link_to(link_text, link_path)
    content_tag(:li, class: active_page_class(link_path)) do
      link_to link_text, link_path
    end
  end

  def active_page_class(path)
    "active" if current_page?(path)
  end

  def viewing_users?
    request.fullpath =~ /users/
  end

  def viewing_intro_meetings?
    request.fullpath =~ /intro_meetings/
  end

  def gravatar_url(email, size="32x32")
    return "" if email.nil?
    hash = Digest::MD5.hexigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  # def formatted_date(date)
  #   date.strftime("%A, %B %e, %Y")
  # end

  # def formatted_time(time)
  #   time.strftime("%l:%M %p")
  # end
end
