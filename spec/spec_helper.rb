require 'nba'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

def fixture_path
  File.expand_path('../../cache', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
