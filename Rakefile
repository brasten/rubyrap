require "rake"

$:.unshift File.expand_path("../lib", __FILE__)

require "rake/rdoctask"
require "rspec"
require "rspec/core/rake_task"

require "rap/version"

RSpec::Core::RakeTask.new(:spec)

#desc "Run all examples using rcov"
#RSpec::Core::RakeTask.new :rcov => :cleanup_rcov_files do |t|
#  t.rcov = true
#  t.rcov_opts =  %[-Ilib -Ispec --exclude "mocks,expectations,gems/*,spec/*,db/*,/Library/Ruby/*,config/*,lib/zip/*,"]
#end

SOURCE_FILES = FileList.new("lib/**/*.rb")

file 'rubyrap-0.1.0.gem' => SOURCE_FILES do
  system('gem build rubyrap.gemspec')
end

task :cleanup_cov_artifacts do
  rm_rf 'coverage'
end

namespace :gem do

  task :build => 'rubyrap-0.1.0.gem'

  task :install => [:build] do
    system('gem install rubyrap-0.1.0.gem')
  end

end

namespace :coverage do

  desc "open coverage report in browser"
  task :open do
    require 'simplecov'
    SimpleCov.start do
      add_filter '/lib/zip/'
      add_filter '/spec/'
    end

    Rake::Task[:spec].invoke()

    system('open coverage/index.html')
  end
end

task :clobber do
  rm_rf 'pkg'
  rm_rf 'tmp'
  rm_rf 'coverage'
end

begin
  require 'yard'

  file 'doc/frames.html' => :'doc:build'

  desc 'build docs'
  task :doc => 'doc:build'

  namespace :doc do

    YARD::Rake::YardocTask.new(:build) do |t|
      t.files   = [
        'app/**/*.rb',
        'lib/**/*.rb'
      ]
      t.options = ['-q']
    end

    desc 'Open docs in web browser'
    task :open => ['doc/frames.html'] do
      system('open doc/frames.html')
    end
  end
rescue LoadError
# BURY
#  puts "YARD not installed -- yardocs unavailable.  Run: gem install yard"
end
