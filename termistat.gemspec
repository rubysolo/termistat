# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "termistat/version"

Gem::Specification.new do |s|
  s.name        = "termistat"
  s.version     = Termistat::VERSION
  s.authors     = ["Solomon White"]
  s.email       = ["rubysolo@gmail.com"]
  s.homepage    = "https://github.com/rubysolo/termistat"
  s.summary     = %q{Terminal status bar}
  s.description = %q{Display status bar overlay for summary information}

  s.rubyforge_project = "termistat"

  s.add_runtime_dependency "ffi-ncurses"
  s.add_development_dependency "rake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
