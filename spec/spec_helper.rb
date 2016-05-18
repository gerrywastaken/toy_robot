require 'pry'
require 'simplecov'
SimpleCov.start

# Load SpecHelpers
require_relative './support/parser_helpers.rb'
RSpec.configure do |config|
  config.include SpecHelpers
end

# The main entry point for the application
load 'toy_robot'
