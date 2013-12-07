require 'fake_braintree'

RSpec.configure do |config|
  config.before(:each) { FakeBraintree.clear! }
end
