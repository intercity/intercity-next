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

reporter_options = { color: true, slow_count: 5 }
ENV["VIM"] = nil
Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new(reporter_options)], ENV)

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation

Capybara.register_server :puma do |app, port, host|
  require 'rack/handler/puma'
  Rack::Handler::Puma.run(app, Host: host, Port: port, Threads: "0:1")
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless window-size=1024,768 no-sandbox) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

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
  include Capybara::DSL

  self.use_transactional_tests = false

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def login_as(user)
    post login_path, params: { login: { email: user.email, password: "secret" } }
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

  def login_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "secret"
    click_button "Login"
  end
end
