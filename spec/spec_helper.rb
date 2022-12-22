require 'bundler'
require 'capybara/dsl'
require 'capybara/rspec'
require 'yaml'

# :selenium_chrome - Selenium driving Chrome
# :selenium_chrome_headless - Selenium driving Chrome in a headless configuration

env_data = YAML.load_file('config/env.yml')

Capybara.default_driver = :selenium_chrome
Capybara.app_host = env_data[:url]
Capybara.default_max_wait_time = 5

RSpec.configure do |config|
  config.formatter = :documentation
end
