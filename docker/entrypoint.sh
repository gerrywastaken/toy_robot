#!/bin/sh

bundle exec rspec spec
bundle exec rubocop
bundle exec reek