require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

namespace :cache do
  require 'nba'
  desc 'Update the teams file cache'
  task :update do
    doc = NBA::Team.results_from_freebase(true)
    File.open('cache/teams.json', 'w') do |file|
      file.write(doc.body)
    end
  end
end

task :default => [:spec]
