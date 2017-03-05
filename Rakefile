require 'rake'

if Gem::Specification::find_all_by_name('rspec').any?
  require 'rspec/core/rake_task'
  task :default => :spec
  task :test => :spec
  desc 'Run all specs'
  RSpec::Core::RakeTask.new('spec') do |spec|
    spec.rspec_opts = %w{}
  end
end
