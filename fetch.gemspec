# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fetch}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["cloudwow"]
  s.date = %q{2010-12-15}
  s.description = %q{fetch stuff and other stuff}
  s.email = %q{david@cloudwow.com}
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/fetch.rb",
     "lib/fetch/acts_as_fetcher.rb",
     "lib/fetch/acts_as_scraper.rb",
     "lib/fetch/acts_throttled.rb",
     "lib/fetch/file_fetcher.rb",
     "lib/fetch/html_utility.rb",
     "lib/fetch/http_fetcher.rb",
     "lib/fetch/robots.rb"
  ]
  s.homepage = %q{http://github.com/cloudwow/fetch}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{fetch stuff}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<nanikore>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<nanikore>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<nanikore>, [">= 0"])
  end
end

