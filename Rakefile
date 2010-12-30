require 'rubygems'
require 'bundler'
require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.summary        = "Ruby library for consuming the Klout API"
  gem.description    = "Klout measures influence on topics across the social web to find the people the world listens to. See http://klout.com for more information about their service"
  gem.authors        = 'Jason Torres'
  gem.email          = 'jason.e.torres@gmail.com'
  gem.homepage       = 'http://github.com/jasontorres/klout'
  gem.name           = "klout"
  gem.license        = "MIT"
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "new_k #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end