module Nib::Command
  def self.included(base)
    base.instance_eval do
      attr_reader :service, :command, :options

      extend ClassMethods
    end
  end

  module ClassMethods
    def execute(args, options = '')
      new(args.shift, args.join(' '), options).execute
    end
  end

  def initialize(service, command, options = '')
    @service = service
    @command = command
    @options = options
  end

  def execute
    exec(script)
  end

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        run \
        --rm \
        #{options} \
        #{service} \
        #{command}
    SCRIPT
  end
end
