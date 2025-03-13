# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
# ##############################
# Must be before any other code:
# ##############################
require "support/coverage"

require "support/mock_site/config/environment"
require "rspec/rails"
require "canvas_inline_pdf"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = ".rspec_status"
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true
end

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Schema.verbose = false
load "#{Rails.root}/db/schema.rb"

CanvasInlinePdf.register_plugin
