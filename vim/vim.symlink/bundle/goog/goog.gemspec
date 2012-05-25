# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'goog'

Gem::Specification.new do |s|
  s.name        = "goog"
  s.version     = Goog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.8.7'

  s.authors     = ["Daniel Choi"]
  s.email       = ["dhchoi@gmail.com"]
  s.homepage    = "https://github.com/danchoi/goog"
  s.summary     = %q{Simple command line interface to Google search}
  s.description = s.summary

  s.rubyforge_project = "goog"

  s.files         = ['bin/goog', 'lib/goog.rb', 'plugin/goog.vim']
  s.executables   = ['goog']
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  # s.require_paths = ["lib"]
  s.add_dependency "nokogiri"

end

