$: <<  "#{File.dirname(__FILE__)}/../lib"
Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each {|f| require f}
require 'coveralls'
Coveralls.wear!

require 'pry'
require 'vcr'
require 'gather_content'

ENV['gather_content_api_key'] = 'api-key'
ENV['gather_content_api_username'] = 'api-id'

VCR.configure do |c|
  c.filter_sensitive_data('api-key') { ENV['gather_content_api_key'] }
  c.filter_sensitive_data('api-id') { ENV['gather_content_api_username'].gsub(/@/,'%40') }
  c.filter_sensitive_data('gather_content_api_host') { ENV['gather_content_api_host'] }
  c.default_cassette_options = { :record => :new_episodes, :allow_playback_repeats => true }
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
end
