require File.join([File.dirname(__FILE__),'lib','nib','version.rb'])

spec = Gem::Specification.new do |s| 
  s.name = 'nib'
  s.version = Nib::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'

  s.files = Dir['lib/**/*.rb']
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'nib'

  s.add_runtime_dependency('gli','2.14.0')

  # s.add_development_dependency('aruba')
  s.add_development_dependency('pry')
  s.add_development_dependency('serverspec')
end
