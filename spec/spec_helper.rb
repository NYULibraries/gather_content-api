require 'coveralls'
Coveralls.wear!

$: <<  "#{File.dirname(__FILE__)}/../lib"
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

require 'pry'
require 'vcr'
require 'gather_content'
require 'climate_control'
# require 'figs'
# Figs.load()

VCR.configure do |c|
  c.filter_sensitive_data('api-id') { GatherContent::Api::Config.instance.username }
  c.filter_sensitive_data('api-key') { GatherContent::Api::Config.instance.api_key }
  c.filter_sensitive_data('gather_content_api_host') { ENV['GATHER_CONTENT_API_HOST'] }
  c.default_cassette_options = { record: :new_episodes, allow_playback_repeats: true }
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
end

def with_modified_env(options, &block)
  ClimateControl.modify(options, &block)
end
