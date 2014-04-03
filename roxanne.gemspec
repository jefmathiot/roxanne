# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roxanne/version'

Gem::Specification.new do |spec|
  spec.name          = "roxanne"
  spec.version       = Roxanne::VERSION
  spec.authors       = ["Jef Mathiot", "Patrice Izzo", "Fabrice Nourisson",
    "Benjamin Severac", "Eric Hartmann"]
  spec.email         = ["foss@servebox.com"]
  spec.description   = %q{Roxanne: publish your CI status to your device of choice}
  spec.summary       = %q{Aggregate the status of Continuous Integration jobs or other sources and
                       publish them}
  spec.homepage      = "http://github.com/servebox/roxanne"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'json'
  spec.add_dependency 'daemon-spawn'
  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_dependency 'taopaipai', '~> 0.1.1'
  spec.add_dependency 'travis', '~> 1.6.8'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0.7"
  spec.add_development_dependency "minitest-implicit-subject", "~> 1.4.0"
  spec.add_development_dependency "rb-readline", "~> 0.5.0"
  spec.add_development_dependency "guard-minitest", "~> 2.1.3"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "mocha"
end
