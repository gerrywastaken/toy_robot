require 'pry'
require 'simplecov'
SimpleCov.start

# Patch to fix a bug in ruby 2.3.0 which has not been pushed to stable yet.
# https://github.com/rspec/rspec-core/issues/2163#issuecomment-193657248
require './lib/core_extensions/ripper_lexer'

load 'toy_robot'
