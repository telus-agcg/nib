module Nib::Options
  CONFIG = [
    {
      names: %i(d),
      type: :switch,
      commands: %i(run exec),
      options: {
        negatable: false,
        desc: 'Detached mode: Run container in the background, print new ' \
          'container name.'
      }
    },
    {
      names: %i(no-deps),
      type: :switch,
      commands: %i(run),
      options: {
        negatable: false,
        desc: 'Don\'t start linked services.'
      }
    },
    {
      names: %i(service-ports),
      type: :switch,
      commands: %i(run),
      options: {
        negatable: false,
        desc: 'Run command with the service\'s ports enabled and mapped to ' \
          'the host'
      }
    },
    {
      names: %i(privileged),
      type: :switch,
      commands: %i(exec),
      options: {
        negatable: false,
        desc: 'Give extended privileges to the process.'
      }
    },
    {
      names: %i(T),
      type: :switch,
      commands: %i(run exec),
      options: {
        negatable: false,
        desc: 'Disable pseudo-tty allocation. By default `docker-compose run`' \
          'allocates a TTY.'
      }
    }
  ].freeze

  module_function

  def options_for(type, name)
    CONFIG.select { |option| option[type].include?(name) }
  end
end
