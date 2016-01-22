source "https://rubygems.org"

gem "rails", "~> 4.2"
gem "pg"
gem "turbolinks"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "bootstrap-sass", "~> 3.3.5"
gem "bootstrap_form"
gem "sass-rails", "~> 5.0"
gem "uglifier"
gem "sidekiq", "~> 4.0"
gem "sidekiq-cron", "~> 0.4.0"
gem "redis", "~> 3.2.0"
gem "nprogress-rails", "~> 0.1.6"
gem "net-ssh"
gem "sshkey", "~> 1.5.1"
gem "font-awesome-sass", "~> 4.4.0"
gem "sinatra", require: nil
gem "sorcery", "~> 0.9.1"
gem "puma", "~> 2.15"
gem "whenever", "~> 0.9"
gem "validates_email_format_of", "~> 1.6"
gem "redcarpet"

group :development do
  gem "spring"
  gem "web-console"
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-rails-console"
  gem "daemon_controller"
  gem "quiet_assets"
  gem "letter_opener"
  gem "meta_request"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "rubocop"
end

group :test do
  gem "minitest-rails-capybara"
  gem "minitest-reporters"
  gem "timecop"
  gem "shoulda"
  gem "mocha"
  gem "launchy"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "codeclimate-test-reporter", require: nil
end

group :staging, :production do
end

source "https://rails-assets.org" do
  gem "rails-assets-fastclick"
end
