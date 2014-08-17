require 'raven'

Rails.configuration.raven = {
  public_key: ENV['RAVEN_PUBLIC_KEY'],
  secret_key: ENV['RAVEN_SECRET_KEY'],
  project_id: ENV['RAVEN_PROJECT_ID']
}

Raven.configure do |config|
  public_key = Rails.configuration.raven[:public_key]
  secret_key = Rails.configuration.raven[:secret_key]
  project_id = Rails.configuration.raven[:project_id]

  config.dsn = "https://#{public_key}:#{secret_key}@app.getsentry.com/#{project_id}"
end
