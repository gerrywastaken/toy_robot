require 'rake'
require 'rspec/core/rake_task'

begin
  RSpec::Core::RakeTask.new(:spec)
  ENV['SPEC_FASTER'] = 'true'
  task default: :spec
# Allow running in environments which do not have RSpec.
rescue LoadError => e
  puts 'Rspec not found so skipping tests: ', e.message
end
