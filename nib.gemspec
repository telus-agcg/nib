require File.join([File.dirname(__FILE__), 'lib', 'nib', 'version.rb'])

Gem::Specification.new do |s|
  s.name = 'nib'
  s.version = Nib::VERSION
  s.authors = ['John Allen', 'Zach Blankenship']
  s.email = ['noreply@technekes.com']
  s.homepage = 'https://github.com/technekes/nib'
  s.platform = Gem::Platform::RUBY
  s.summary = 'The tip of the pen (compose)'

  s.description = <<-DESCRIPTION
    nib is a docker-compose wrapper geared towards Ruby/Rails development.
  DESCRIPTION

  s.required_ruby_version = '>= 2.7.5'

  s.files = Dir['lib/**/*.rb'] | Dir['config/**/*'] | ['VERSION']
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'nib'

  s.metadata['rubygems_mfa_required'] = 'true'

  s.add_runtime_dependency('gli', '~> 2.16')

  s.add_development_dependency('pry')
  s.add_development_dependency('rake')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('serverspec')
  s.add_development_dependency('simplecov')
end
