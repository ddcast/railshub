require 'json_matchers/rspec'
require 'rspec/json_expectations'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include RSpec::JsonExpectations::Matchers
end
