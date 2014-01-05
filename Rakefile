require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

namespace :cache do
  require 'nba'
  desc 'Update the teams file cache'
  task :update do
    doc = NBA::Team.results_from_freebase
    File.write('cache/teams.json', JSON.pretty_generate(doc))
    FileUtils.cp('cache/teams.json', 'spec/fixtures/')
  end
end

task :default => [:spec]
