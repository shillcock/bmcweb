require 'fake_braintree'

RSpec.configure do |config|
  config.before do
    FakeBraintree.clear!
  end
end
