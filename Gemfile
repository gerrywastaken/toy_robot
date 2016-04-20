source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
end

group :development do
  # Linting tools
  gem 'guard-yield' # run a proc that on guard hooks without extra gems
  gem 'guard-rspec', require: false # rerun tests
  gem 'fuubar', require: false # Allows seeing failures immediately

  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'rspec'

  gem 'pry-rescue' # inspecting failing tests
  gem 'pry-stack_explorer' # needed by pry-rescue

  gem 'simplecov', require: false
end
