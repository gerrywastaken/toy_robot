require 'pry'
require 'simplecov'
SimpleCov.start

# Load SpecHelpers
require_relative './support/parser_helpers.rb'
RSpec.configure do |config|
  config.include SpecHelpers
end

# Patch to fix a bug in ruby 2.3.0 which has not been pushed to stable yet.
# https://github.com/rspec/rspec-core/issues/2163#issuecomment-193657248
require './lib/core_extensions/ripper_lexer'

# The main entry point for the application
load 'toy_robot'
