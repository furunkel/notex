# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notex/version'

Gem::Specification.new do |spec|
  spec.name          = "notex"
  spec.version       = Notex::VERSION
  spec.authors       = ["Julian Aron Prenner"]
  spec.email         = ["julian@linux4you.it"]
  spec.description   = %q{...}
  spec.summary       = %q{...}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "prawn"
end
