ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "active_support/testing/setup_and_teardown"
require "sidekiq/testing"
require 'minitest/mock'
require "mocha/mini_test"
require "minitest/rails/capybara"
require "minitest/reporters"
require "database_cleaner"
require "capybara/poltergeist"

Sidekiq::Testing.fake!
Minitest::Reporters.use!(
  Minitest::Reporters::DefaultReporter.new(color: true),
  ENV, Minitest.backtrace_filter)

DatabaseCleaner.strategy = :transaction

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def self.check_for_valid_fixtures(name)
    Object.const_get(name.to_s.camelize).all.each do |obj|
      raise "Fixtures for #{name} should be valid - #{obj.errors.messages}" unless obj.valid?
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, window_size: [1920, 1024])
  end
  Capybara.javascript_driver = :poltergeist

  setup do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def login_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "secret"
    click_button "Sign in"
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def use_javascript
    Capybara.current_driver = Capybara.javascript_driver
  end
end
