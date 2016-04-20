# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

# bundler 1.12.0 will support frozen strings, but until then I will run rspec
# outside of bundler
# guard :rspec, cmd: 'bundle exec rspec' do
guard :rspec, cmd: 'rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

# guard-yield:
#
# Instead of adding an entire gem (e.g. guard-rubocop, guard-reek) for each
# command we want guard to execute, guard-yield allows use to just execute the
# command and pass a list of changed files.
misc_guard = proc do |_guard, _command, files|
  files = Array(files)

  puts 'Reek checks'
  puts `reek --color #{files.join}`

  puts 'RuboCop checks'
  puts `rubocop --color #{files.join}`
end

yield_commands = {
  start: misc_guard,
  run_all: misc_guard,
  reload: misc_guard,
  run_on_additions: misc_guard,
  run_on_modifications: misc_guard,
  run_on_changes: misc_guard
}

guard :yield, yield_commands do
  watch(/.+\.rb$/)
end
