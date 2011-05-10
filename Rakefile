require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "fetch"
    gem.summary = %Q{fetch stuff}
    gem.description = %Q{fetch stuff and other stuff}
    gem.email = "david@cloudwow.com"
    gem.homepage = "http://github.com/cloudwow/fetch"
    gem.authors = ["cloudwow"]
    gem.add_development_dependency "thoughtbot-shoulda"
    gem.add_dependency "nanikore"
    # gem is a Gem::Specification... see
    # http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files=[".document",
               ".gitignore",
               "LICENSE",
               "README.rdoc",
               "Rakefile",
               "VERSION",
               "lib/fetch.rb",
               "lib/fetch/acts_as_fetcher.rb",
               "lib/fetch/acts_throttled.rb",
               "lib/fetch/http_fetcher.rb",
               "lib/fetch/file_fetcher.rb",
               "lib/fetch/html_utility.rb",
               "lib/fetch/acts_as_scraper.rb",
               "lib/fetch/robots.rb"

              ]

    gem.test_files=[]
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fetch #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
task :tags  do
  files = FileList['**/*.rb'].exclude("vendor")

  puts "Making Emacs TAGS file"


  sh "ctags -e #{files}", :verbose => false

end
