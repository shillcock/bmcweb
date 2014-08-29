require 'digest/md5'

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
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?d=identicon&s=#{size}"
  end

  def stripe_url(type, id)
    id ? "https://dashboard.stripe.com/test/#{type}/#{id}" : "#"
  end

  def stripe_customers_url(id)
    stripe_url(:customers, id)
  end

  def stripe_payments_url(id)
    stripe_url(:payments, id)
  end

  def stripe_invoices_url(id)
    stripe_url(:invoices, id)
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

  def formatted_birthday(bday)
    bday ? bday.strftime("%B %e") : ""
  end

  def formatted_date(date)
    date ? date.strftime("%A, %B %e, %Y") : ""
  end

  def formatted_time(time)
    time ? time.strftime("%l:%M %p") : ""
  end

  def formatted_datetime(datetime)
    datetime ? datetime.strftime("%m/%d/%Y %I:%M %p") : ""
  end
end
