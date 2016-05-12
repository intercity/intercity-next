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
require 'capybara/poltergeist'

Sidekiq::Testing.fake!

reporter_options = { color: true, slow_count: 5 }
ENV["VIM"] = nil
Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new(reporter_options)], ENV)

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  fixtures :all

  def setup
    SshExecution.executioner = FakeSshExecutioner
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

  self.use_transactional_tests = false

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: true)
  end
  Capybara.javascript_driver = :poltergeist

  teardown do
    DatabaseCleaner.clean
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

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until page.evaluate_script('jQuery.active').zero?
    end
  end

  def interact_with_hidden_elements
    return unless block_given?
    Capybara.ignore_hidden_elements = false
    yield
    Capybara.ignore_hidden_elements = true
  end
end
