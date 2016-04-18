source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
end

group :development do
  # Linting tools
  gem 'reek'
  gem 'rubocop'
end

group :test do
  gem 'rspec'
  gem 'pry-rescue' # inspecting failing tests
  gem 'pry-stack_explorer' # needed by pry-rescue
  gem 'guard-rspec' # reruns tests
  gem 'simplecov', require: false
end
