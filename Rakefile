require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'

  pattern = 'spec/integration/*_spec.rb'

  namespace :rspec do
    desc 'Run unit specs'
    RSpec::Core::RakeTask.new(:unit) do |task|
      task.rspec_opts = "--exclude-pattern '#{pattern}'"
    end

    desc 'Run integration specs'
    RSpec::Core::RakeTask.new(:integration) do |task|
      ENV['INTEGRATION'] = 'true'
      task.rspec_opts = "--pattern '#{pattern}'"
    end
  end

  task spec: %w(rspec:unit rspec:integration)
  task default: %i(spec)
rescue LoadError
  # no rspec available
end
