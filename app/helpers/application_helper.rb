module ApplicationHelper
  def active_page_class(path)
    "active" if current_page?(path)
  end

  def active_path_class(path)
    "active" if viewing_path?(path)
  end

  def viewing_path?(path)
    request.fullpath =~ /#{path}/
  end

  def gravatar_url(email, size="32x32")
    return "" if email.nil?
    hash = Digest::MD5.hexigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def stripe_customer_url(id)
    id ? "https://dashboard.stripe.com/test/customers/#{id}" : ""
  end

  def stripe_subscription_url(id)
    id ? "https://dashboard.stripe.com/test/subscriptions/#{id}" : ""
  end

  def alumni_level(amount)
    if amount <= 40
      "Awesome"
    elsif amount <= 90
      "Fantastic"
    elsif amount <= 175
      "Magnificent"
    else
      "Wild and Wooly"
    end
  end

  def alumni_plan(interval)
    if interval == "year"
      "alumni_yearly"
    else
      "alumni_monthly"
    end
  end

  # def formatted_date(date)
  #   date.strftime("%A, %B %e, %Y")
  # end

  # def formatted_time(time)
  #   time.strftime("%l:%M %p")
  # end
end
