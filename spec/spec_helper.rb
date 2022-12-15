# ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'
require File.join(File.dirname(__FILE__), '..', 'app.rb')
require_relative 'setup_test_database'

require 'simplecov'
require 'simplecov-console'
require 'capybara'
require 'capybara/rspec'
require 'rspec'

Capybara.app = ChitterApp


RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end

  def create_user_from_database
    connection = PG.connect(dbname: 'chit_test')
    connection.exec("
        INSERT INTO users (username, email, password)
        VALUES ('Jelly', 'jelly@jelly.com', 'passworD1!');
                    ")
    connection
  end

  def create_user_from_database
    connection = PG.connect(dbname: 'chit_test')
    connection.exec("
        INSERT INTO users (username, email, password)
        VALUES ('Jelly', 'jelly@jelly.com', 'passworD1!');
                    ")
    connection
  end

end


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
