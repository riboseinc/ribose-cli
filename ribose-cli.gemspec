# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ribose/cli/version"

Gem::Specification.new do |spec|
  spec.name          = "ribose-cli"
  spec.version       = Ribose::CLI::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["operations@ribose.com"]

  spec.summary       = "The Ribose CLI"
  spec.description   = "The Ribose CLI"
  spec.homepage      = "https://github.com/riboseinc/ribose-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")

  spec.require_paths = ["lib"]
  spec.bindir        = "bin"
  spec.executables   = "ribose"

  spec.add_dependency "thor", "~> 0.19.4"
  spec.add_dependency "ribose", ">= 0.5"
  spec.add_dependency "terminal-table"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
