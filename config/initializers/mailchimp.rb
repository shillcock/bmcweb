Rails.configuration.mailchimp = {
  enabled: Rails.env.production? && ENV['MAILCHIMP_BMC_LIST_ID'],
  bmc_list_id: ENV['MAILCHIMP_BMC_LIST_ID']
}
