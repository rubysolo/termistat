require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.pattern = 'test/**/test_*.rb'
  t.warning = true
end

task :default => :test

