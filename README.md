![nib logo](nib.png)

`nib` is a `docker-compose` wrapper geared towards Ruby/Rails development.

## Install

To install:

```sh
> gem install nib
```

## Update

If there is an update available it's a good idea to remove the current version before installing the new version. If you skip the uninstall then `gem update nib` will install the new version along side the existing version.

```sh
> gem uninstall -ax nib && gem install nib
```

... or let `nib` take care of that for your.

```sh
> nib update
```

## Usage

`nib` can be used as a replacement for `docker-compose` any commands that it does not recognize will be delegated to `docker-compose`.

The commands provided by `nib` are intended to provide a convenient and practical workflow for development, for example:

```sh
> nib shell web
root@fd80bbc4ab5a:/usr/src/app#
```

1. `nib` will start up a container for the `web` service and drop you into an interactive shell session (`bash`, `ash` or `sh`) depending on which shell is available.
1. `nib` will also hook up a history file for your shell session (relative to the current project). This means that you will be able to use the history (up arrow) in future shell sessions, something that is not available with vanilla docker/docker-compose!
1. Finally `nib` will ensure that the container is removed after you finish with the shell session

Some commands can have their behavior changed relative to a particular project. As an example - `nib console` expects a Ruby like environment (`rails console` or `pry` etc) by default but it can be augmented by adding a custom script on the host system (`$pwd/bin/console`)

Other commands like `nib rake` or `nib guard` behave as expected without the option to change the behavior.

For additional information and a list of [supported commands](./docs/commands.md) review the help system.

```sh
> nib help
```

## Debugging

nib can help facilitate remote debugging of a running byebug server inside of a rails application. In order to make this work there are a couple of steps you'll need to take first.

Add the `byebug` gem to your Gemfile if it's not already present.

```ruby
# Gemfile
gem 'byebug'
```

Enable byebug server for development. This will default the port to 9005 but that can be overridden by setting the `RUBY_DEBUG_PORT` environment variable (see below).

```ruby
# config/envrionments/development.rb
require 'byebug/core'
Byebug.start_server '0.0.0.0', (ENV.fetch 'RUBY_DEBUG_PORT', 9005).to_i
```

Expose the desired port and specify the `RUBY_DEBUG_PORT` environment variable (overrides the default).

```yml
# docker-compose.yml
web:
  ...
  ports:
    - "3001:3001"
  environment:
    - "RUBY_DEBUG_PORT=3001"
```

Once all of this is in place and the web service is up and running (`nib up`) you can use the `debug` command to attach to the remote debugger.

```sh
> nib debug web
```

## Plugins

nib is pluggable via additional gems. The plugin system is loosely based on that of [minitest](https://github.com/seattlerb/minitest#writing-extensions) extensions. There are three requirements for a nib plugin:

1. A Ruby gem that relies on [gli](https://github.com/davetron5000/gli) for defining it's CLI interface following the naming convention `bin/nib-*`
1. It puts a file on the `LOAD_PATH` that ends with `_plugin.rb` following the naming convention `./lib/nib_*_plugin.rb`
1. Implements `#applies?`, which allows the plugin to "self-select" (ie. was this command run in what appears to be an applicable project)

### Plugin Example

As an example let's define a plugin for nib that caters to Ruby developers.

```ruby
# ./bin/nib-ruby

#!/usr/bin/env ruby

command :hello do |c|
  c.action do |_global_options, _options, _args|
    puts 'from nib-ruby'
  end
end
```

```ruby
# ./lib/nib_ruby_plugin.rb

module Nib
  module Ruby
    def self.applies?
      !Dir.glob('Gemfile').empty?
    end
  end
end
```

```ruby
# ./nib-ruby.gemspec

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
...
```

If nib-ruby has been installed and a nib command is run from a directory containing a `Gemfile` nib will append gli commands from `bin/nib-ruby`.

## Running Specs

This project includes [rspec](http://rspec.info/) and [serverspec](http://serverspec.org/) to help facilitate execution of automated tests. Running the tests is as simple as:

```sh
nib build # the first time (you are using `nib` right?)
nib rspec gem
```

## Generating Docs

If you have added a new command you will want to regenerate the [commands document](./docs/commands.md). The following command should get that done:

```sh
docker run \
  --rm \
  -v $PWD:/usr/src/app \
  -w /usr/src/app \
  ruby:3.3.0 bin/update_docs
```

## Contributing

`nib` is work of several contributors. You're encouraged to submit pull requests, propose features and discuss issues.

See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE) for details.
