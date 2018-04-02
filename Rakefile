#test_dir = File.expand_path("./test", __FILE__)
#$LOAD_PATH.unshift(test_dir) unless $LOAD_PATH.include?(test_dir)
require 'bundler/gem_tasks'
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.verbose = true
  t.libs << "test"
  t.libs << "lib"
  test_path = File.expand_path("../test/**/*_test.rb", __FILE__)
  t.test_files = FileList[test_path]
end
desc "Run tests"

task :default => :test
