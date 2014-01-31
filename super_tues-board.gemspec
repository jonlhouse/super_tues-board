# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_tues/board/version'

Gem::Specification.new do |spec|
  spec.name          = "super_tues-board"
  spec.version       = SuperTues::Board::VERSION
  spec.authors       = ["John House"]
  spec.email         = ["jonlhouse@gmail.com"]
  spec.summary       = %q{SuperTues e-Boardgame Game Logic}
  spec.description   = %q{Contains the classes and logic to play Super Tuesday.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", '~> 4.0.2'

  spec.add_development_dependency "bundler", "~> 1.5"  
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
