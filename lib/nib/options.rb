module Nib::Options
  CONFIG = [
    {
      names: %i(d),
      type: :switch,
      commands: %i(exec run),
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
      commands: %i(exec run),
      options: {
        negatable: false,
        desc: 'Disable pseudo-tty allocation. By default `docker-compose ' \
          'run` allocates a TTY.'
      }
    },
    {
      names: %i(name),
      type: :flag,
      commands: %i(run),
      options: {
        arg_name: 'NAME',
        desc: 'Assign a name to the container',
        multiple: false,
        type: String
      }
    },
    {
      names: %i(entrypoint),
      type: :flag,
      commands: %i(run),
      options: {
        arg_name: 'CMD',
        desc: 'Override the entrypoint of the image.',
        multiple: false,
        type: String
      }
    },
    {
      names: %i(e),
      type: :flag,
      commands: %i(run),
      options: {
        arg_name: 'KEY=VAL',
        desc: 'Set an environment variable',
        multiple: true,
        type: String
      }
    },
    {
      names: %i(u user),
      type: :flag,
      commands: %i(exec run),
      options: {
        arg_name: '""',
        desc: 'Run as specified username or uid',
        multiple: false,
        type: String
      }
    },
    {
      names: %i(p publish),
      type: :flag,
      commands: %i(run),
      options: {
        arg_name: '[]',
        desc: 'Publish a container\'s port(s) to the host',
        multiple: false,
        type: Array
      }
    },
    {
      names: %i(workdir),
      type: :flag,
      commands: %i(run),
      options: {
        arg_name: '""',
        desc: 'Working directory inside the container',
        multiple: false,
        type: String
      }
    },
    {
      names: %i(index),
      type: :flag,
      commands: %i(exec),
      options: {
        arg_name: 'index',
        desc: 'index of the container if there are multiple instances of a ' \
          'service [default: 1]',
        multiple: false,
        type: String
      }
    }
  ].freeze

  module_function

  def options_for(type, name)
    CONFIG.select { |option| option[type].include?(name) }
  end
end
