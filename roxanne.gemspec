# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roxanne/version'

Gem::Specification.new do |spec|
  spec.name          = "roxanne"
  spec.version       = Roxanne::VERSION
  spec.authors       = ["Jef Mathiot"]
  spec.email         = ["jeff.mathiot@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'json'
  spec.add_dependency 'daemon-spawn'
  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_dependency 'taopaipai', '~> 0.1.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0.7"
  spec.add_development_dependency "minitest-implicit-subject", "~> 1.4.0"
  spec.add_development_dependency "rb-readline", "~> 0.5.0"
  spec.add_development_dependency "guard-minitest", "~> 2.1.3"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "mocha"
end
