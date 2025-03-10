# frozen_string_literal: true

# ################################################################################
# Sets up Code coverage.
# - Code Coverage (in this case simplecov) analyzes a test run to verify that
#   all the code in the project is executed at least once by the unit tests.
# - This is very important for a language like ruby which is interpreted, and therefore
#   we don't get some of the benefits that a compiler would give (such as finding syntax
#   errors)
# ################################################################################
require "simplecov"
require "simplecov_lcov_formatter"

# Use LCOV format for github reports.
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true

SimpleCov.start do
  enable_coverage :branch
  add_filter "/spec/"

  if ENV["CI"]
    formatter SimpleCov::Formatter::LcovFormatter
  else
    formatter SimpleCov::Formatter::HTMLFormatter
  end
end

# If there are parts of the code we cannot test, we can tell simplecov to
# skip lines.
SimpleCov.minimum_coverage line: 100, branch: 100
