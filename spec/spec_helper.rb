require 'bundler/setup'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'raven_client'

RSpec.configure do |config|
  # some (optional) config here
end
