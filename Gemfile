source 'https://rubygems.org'

gem 'circular_list' # Used to make robot turning easy and readable

group :development, :test do
  # Required by Travis CI.
  # see: https://docs.travis-ci.com/user/languages/ruby#Default-Test-Script
  gem 'rake'
end

group :development do
  # Linting tools
  gem 'fuubar', require: false # Allows seeing failures immediately
  gem 'guard-rspec', require: false # rerun tests
  gem 'guard-yield' # run a proc that on guard hooks without extra gems

  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'pry-rescue' # inspecting failing tests
  gem 'pry-stack_explorer' # needed by pry-rescue

  gem 'rspec'

  gem 'simplecov', require: false
end
