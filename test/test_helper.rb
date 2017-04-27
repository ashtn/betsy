require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"

#  For colorful output!
Minitest::Reporters.use!(
Minitest::Reporters::SpecReporter.new,
ENV,
Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  def login_merchant(merchant)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))

    get auth_github_callback_path
  end

  def mock_auth_hash(merchant)
    return {
      provider: merchant.provider,
      uid: merchant.uid,
      info: {
        email: merchant.email,
        nickname: merchant.username
      }
    }
  end

  def setup
    OmniAuth.config.test_mode = true
  end
end
