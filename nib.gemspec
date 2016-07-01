require File.join([File.dirname(__FILE__),'lib','nib','version.rb'])

spec = Gem::Specification.new do |s| 
  s.name = 'nib'
  s.version = Nib::VERSION
  s.authors = ['John Allen', 'Zach Blankenship']
  s.email = ['noreply@technekes.com']
  s.homepage = 'https://github.com/technekes/nib'
  s.platform = Gem::Platform::RUBY
  s.summary = 'The tip of the pen (compose)'

  s.description = <<~'DESCRIPTION'
    nib is a docker-compose wrapper geared towards Ruby/Rails development.
  DESCRIPTION

  s.files = Dir['lib/**/*.rb']
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'nib'

  s.add_runtime_dependency('gli','2.14.0')

  s.add_development_dependency('pry')
  s.add_development_dependency('serverspec')
end
