module Nib::Command
  def self.included(base)
    base.instance_eval do
      attr_reader :service, :command, :raw_options

      extend ClassMethods
    end
  end

  module ClassMethods
    def execute(raw_options, args)
      # - first argument is (almost) always the service
      # - pass the remaining arguments along as command
      # - gli sends a string and symbol version of options, reduce to string
      #   > { 'enabled' => true, :enabled => true }.map { |k, v| [k.to_s, v] }
      #   => { 'enabled' => true }
      new(
        args.shift,
        args.join(' '),
        raw_options.map { |k, v| [k.to_s, v] }.to_h
      ).execute
    end
  end

  def initialize(service, command, raw_options = {})
    @service = service
    @command = command
    @raw_options = raw_options
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

  private

  def parsed_options
    []
  end

  def options
    parsed_options.join(' ')
  end
end
