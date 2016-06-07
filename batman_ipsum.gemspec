# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batman_ipsum/version'

Gem::Specification.new do |spec|
  spec.name          = "batman_ipsum"
  spec.version       = BatmanIpsum::VERSION
  spec.authors       = ["Dirk Breuer"]
  spec.email         = ["github@breuer.io"]

  spec.summary       = %q{Ruby CLI for http://batman-ipsum.com/}
  spec.description   = %q{For fun and education purpose I needed a small project. This makes Batman Ipsum (http://batman-ipsum.com/) available as Ruby CLI.}
  spec.homepage      = "https://github.com/wpf-social-coding/batman-ipsum"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "batman_ipsum"
  spec.require_paths = ["lib"]

  spec.add_dependency "gli", "~> 2.14"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "pry"
end
