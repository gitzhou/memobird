lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memobird/version'

Gem::Specification.new do |spec|
  spec.name = 'memobird'
  spec.version = Memobird::VERSION
  spec.authors = ['aaron67']
  spec.email = ['aaron67@aaron67.cc']

  spec.summary = %q{封装咕咕机官方API}
  spec.description = %q{封装咕咕机官方提供的打印接口}
  spec.homepage = 'https://github.com/gitzhou/memobird'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'addressable', '~>2.5.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'http', '~>2.1.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
