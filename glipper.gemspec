# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glipper/version'

Gem::Specification.new do |spec|
  spec.name          = "glipper"
  spec.version       = Glipper::VERSION
  spec.authors       = ["Alexey Osipenko"]
  spec.email         = ["alexey@cimon.io"]
  spec.summary       = %q{Implementation of drapers for the rails views}
  spec.description   = %q{Implementation of drapers for the rails views}
  spec.homepage      = "https://github.com/cimon-ci/glipper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'actionpack', '>= 4.1.1', '< 8.0'

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake'
end
