# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amzwish}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Tinning"]
  s.date = %q{2010-10-10}
  s.description = %q{Since you can no longer access wishlists through the Amazon api this gem aims to address this by combining some screen scraping with api calls.}
  s.email = %q{chris.tinning@gmail.com}
  s.executables = ["amzwish", "amzwish"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".autotest",
     ".gitignore",
     ".rvmrc",
     "VERSION",
     "autotest/discover.rb",
     "bin/amzwish",
     "keys.rb",
     "lib/amzwish.rb",
     "lib/amzwish/book.rb",
     "lib/amzwish/services/website_wrapper.rb",
     "lib/amzwish/wishlist.rb",
     "samples/create_key_sample.rb",
     "samples/uk/empty.html",
     "samples/uk/multipage-page1.html",
     "samples/uk/multipage-page2.html",
     "samples/uk/multipage-page3.html",
     "samples/uk/multipage-page4.html",
     "samples/uk/single-item.html",
     "samples/wishlist_scrape_sample.rb",
     "spec/amzwish/book_spec.rb",
     "spec/amzwish/page_spec.rb",
     "spec/amzwish/services/website_wrapper_spec.rb",
     "spec/amzwish/wishlist_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/tinman/amzwish}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Get at Amazon wishlists combines scraping and the api}
  s.test_files = [
    "spec/amzwish/book_spec.rb",
     "spec/amzwish/page_spec.rb",
     "spec/amzwish/services/website_wrapper_spec.rb",
     "spec/amzwish/wishlist_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
  end
end
