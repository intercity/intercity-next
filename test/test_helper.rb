require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "active_support/testing/setup_and_teardown"
require "sidekiq/testing"
require 'minitest/mock'
require "mocha/mini_test"
require "minitest/reporters"
require "database_cleaner"

Sidekiq::Testing.fake!
Minitest::Reporters.use!(
  Minitest::Reporters::DefaultReporter.new(color: true),
  ENV, Minitest.backtrace_filter)

DatabaseCleaner.strategy = :transaction

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  fixtures :all

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def self.check_for_valid_fixtures(name)
    Object.const_get(name.to_s.camelize).all.each do |obj|
      raise "Fixtures for #{name} should be valid - #{obj.errors.messages}" unless obj.valid?
    end
  end
end

class ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller
end

class ActionDispatch::IntegrationTest
  include Sorcery::TestHelpers::Rails::Integration
  include Capybara::DSL

  use_transactional_fixtures = false

  Capybara.javascript_driver = :webkit

  setup do
    DatabaseCleaner.strategy = :truncation
  end

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def login_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "secret"
    click_button "Login"
  end

  def use_javascript
    Capybara.current_driver = Capybara.javascript_driver
  end
end
