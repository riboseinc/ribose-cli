# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ribose/cli/version"

Gem::Specification.new do |spec|
  spec.name          = "ribose-cli"
  spec.version       = Ribose::Cli::VERSION
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

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
