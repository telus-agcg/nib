
# Supported Commands

The following commands are available:


### `bundle`

Run bundle for the given service




### `codeclimate`

Run codeclimate againt the current working directory




### `console`

Start a REPL session for the given service

This command will try to detect the applications environment (ie. rails console or bundle console)
and start the most appropriate REPL possible. It's possible to directly override this behaviour by
supplying an executable file at $pwd/bin/console.


### `debug`

Connect to a running byebug server for a given service

This command requires a little extra setup.

  The byebug server must be running inside of a web service
   The RUBY_DEBUG_PORT must be defined in docker-compose.yml for the service
    The debug port must be exposed by the service


### `exec`

Attach an interactive shell session to a running container




### `guard`

Run the guard command for the given service




### `rails`

Run the rails command for the given service




### `rake`

Run the rake command for the given service




### `rspec`

Runs the rspec command for the given service




### `rubocop`

Runs the rubocop command for the given service




### `run`

Wraps normal 'docker-compose run' to ensure that --rm is always passed




### `setup`

Runs application specific setup for the given service

By default the setup command will execute 'bundle install && rake db:create db:migrate'.

This behavior can be overriden by providing an executable file in the project at $pwd/bin/setup.
Additionally the setup process can be augmented by providing either $pwd/bin/setup.before or
$pwd/bin/setup.after. This allows for extending the default behavior without having to redefine it.


### `shell`

Start a shell session in a one-off service container




### `update`

Download the latest version of the nib tool



