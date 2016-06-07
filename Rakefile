require "rake/clean"
require "bundler/gem_tasks"
require "cucumber"
require "cucumber/rake/task"
require "rspec/core/rake_task"

CUKE_RESULTS = "results.html"
CLEAN << CUKE_RESULTS

desc "Run features"
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV["TAGS"]}" if ENV["TAGS"]
  t.cucumber_opts =  opts
  t.fork = false
end

desc "Run features tagged as work-in-progress (@wip)"
Cucumber::Rake::Task.new("features:wip") do |t|
  tag_opts = " --tags ~@pending"
  tag_opts = " --tags @wip"
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty -x -s#{tag_opts}"
  t.fork = false
end

task :cucumber => :features

task "cucumber:wip" => "features:wip"

task :wip => "features:wip"

RSpec::Core::RakeTask.new(:spec)

task default: %i(spec features)
