module Nib::Command
  def self.included(base)
    base.instance_eval do
      attr_reader :service, :command

      extend ClassMethods
    end
  end

  module ClassMethods
    def execute(_, args)
      new(args.shift, args.join(' ')).execute
    end
  end

  def initialize(service, command)
    @service = service
    @command = command
  end

  def execute
    exec(script)
  end

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        run \
        --rm \
        #{service} \
        #{command}
    SCRIPT
  end
end
