require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--color"]
end

desc "Run RSpec with code coverage"
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task["spec"].execute
  `open coverage/index.html`
end
