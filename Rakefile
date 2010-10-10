require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "amzwish"
    gem.summary = %Q{Get at Amazon wishlists combines scraping and the api}
    gem.description = %Q{Since you can no longer access wishlists through the Amazon api this gem aims to address this by combining some screen scraping with api calls.}
    gem.email = "chris.tinning@gmail.com"
    gem.homepage = "http://github.com/tinman/amzwish"
    gem.authors = ["Chris Tinning"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "nokogiri"
    gem.add_dependency "nokogiri"
    gem.add_dependency "rest-client"
    gem.executables << "amzwish"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "amzwish #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
