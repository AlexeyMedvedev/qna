require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.use_transactional_fixtures = false # Отключить

  config.include AcceptanceHelper, type: :feature # для макросов из spec/support/acceptance_helpers.rb

  # это все для database_cleaner
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end