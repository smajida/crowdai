ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'pundit/matchers'
require 'rspec/rails'
require 'devise'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'support/controller_helpers'
require 'support/login_helper'
require 'features/support/navigation_helpers'
require 'features/support/challenge_helpers'
require 'support/feature_helpers'
require 'support/helpers/header_helpers'


ActiveRecord::Migration.maintain_test_schema!

Capybara.asset_host = 'http://localhost:3001'
Capybara.javascript_driver = :webkit
Capybara.server_port = 52508  # port registered with Amazon S3 CORS config
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  filename = File.basename(path)
  driver.browser.save_screenshot("#{Rails.root}/tmp/capybara/#{filename}")
end
Capybara::Webkit.configure do |config|
  config.allow_url("cdn.mathjax.org")
  config.allow_url("www.gravatar.com")
end

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
  config.ignore_ssl_errors
end

RSpec.configure do |config|
  Capybara.reset_sessions!

  #config.filter_run :focus => true
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :helper
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.include ControllerHelpers, type: :controller
  config.include HeaderHelpers

  config.include LoginHelper, type: :feature
  config.include NavigationHelpers, type: :feature
  config.include ChallengeHelpers, type: :feature
  config.include FeatureHelpers, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
