$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("config/environment", ENV['RAILS_ROOT'] || File.expand_path("../internal", __FILE__))
require 'rspec/rails'


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.before(:each, :type=>"controller") { @routes = Bpl::InstitutionManagement::Engine.routes }
  config.include Devise::TestHelpers, :type => :controller
  
end
