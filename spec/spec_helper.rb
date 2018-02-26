require 'coveralls'
Coveralls.wear!

$: <<  "#{File.dirname(__FILE__)}/../lib"
Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each {|f| require f}

require 'pry'
require 'vcr'
require 'gather_content'
# require 'figs'
# Figs.load()

#ENV['GATHER_CONTENT_API_KEY'] = 'api-key'
#ENV['GATHER_CONTENT_API_USERNAME'] = 'api-id'

VCR.configure do |c|
  c.filter_sensitive_data('api-key') { ENV['GATHER_CONTENT_API_KEY'] }
  c.filter_sensitive_data('api-id') { ENV['GATHER_CONTENT_API_USERNAME'].gsub(/@/,'%40') }
  c.filter_sensitive_data('gather_content_api_host') { ENV['GATHER_CONTENT_API_HOST'] }
  c.default_cassette_options = { record: :new_episodes, allow_playback_repeats: true }
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
end
