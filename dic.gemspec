# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dic/version"

Gem::Specification.new do |s|
  s.name        = "dic"
  s.version     = Dic::VERSION
  s.authors     = ["Thomas Sonntag"]
  s.email       = ["git@sonntagsbox.de"]
  s.homepage    = ""
  s.summary     = %q{Simple dependency injection container}
  s.description = %q{Simple dependency injection container}

  s.rubyforge_project = "dic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
end
