require 'rest-client'
require 'rspec'
require 'allure-rspec'
require 'faker'
require 'ryba'
require 'yaml'

require 'helpers/api_access'
require 'helpers/application_helper'

Dir['**/lib/**/*.rb'].each { |file| require file[4..-1] }

include ApiAccess
include ApplicationHelper

::CREDENTIALS = YAML.safe_load(File.read('lib/configs/credentials.yml'))
::URL = YAML.safe_load(File.read('lib/configs/env.yml'))['url']

RSpec.configure do |config|
  config.include AllureRSpec::Adaptor
  config.formatter = 'doc'
  config.color = true
  config.tty = true
  config.example_status_persistence_file_path = 'examples.txt'
  config.expect_with :rspec
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

# RestClient.proxy = 'http://127.0.0.1:8888'

AllureRSpec.configure do |config|
  config.output_dir = 'allure'
  config.clean_dir = false
  config.logging_level = Logger::INFO
end
