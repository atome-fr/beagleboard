
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beagleboard/version'

Gem::Specification.new do |spec|
  spec.name          = 'beagleboard'
  spec.version       = Beagleboard::VERSION
  spec.authors       = ['atome']
  spec.email         = ['contact@atome.io']

  spec.summary       = 'Library to manipulate beagleBoard devices.'
  spec.homepage      = 'https://github.com/atome-fr/beagleboard'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ffi'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
