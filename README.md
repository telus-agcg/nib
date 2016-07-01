# nib

`nib` is a `docker-compose` wrapper geared towards Ruby/Rails development.

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

Some commands can have their behavior changed relative to a particiulair project. As an example - `nib console` expects a Ruby like environment (`rails console` or `pry` etc) by default but it can be augmented by adding a custom script on the host system (`$pwd/bin/console`)

Other commands like `nib rake` or `nib guard` behave as expected without the option to change the behavior.

For additional information and a list of [supported commands](./docs/commands.md) review the help system.

```sh
> nib help
```

## Install

1. The most convenient way to use nib is by creating an alias or shell function. Here is an alias you can add to your profile that will make `nib` appear as a command.

    ```sh
    alias nib='
      docker run \
        -it \
        --rm \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        -v $HOME/.docker:/root/.docker:ro \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e "DOCKER_HOST_URL=$DOCKER_HOST" \
        technekes/nib'
    ```

1. Start a new bash session and run `nib help` to see the available commands (there may be a brief pause as the image is pulled from docker hub)

## Updates

To get the latest version of `nib` use the `update` command. This just pulls the latest version of `technekes/nib:latest` from the Docker Hub.

```sh
❯ nib update
latest: Pulling from technekes/nib
03e1855d4f31: Already exists
a3ed95caeb02: Already exists
8bfa9c6cbe2e: Already exists
48868f5a50c8: Already exists
Digest: sha256:47a8796f7f4f35fef13c67f14e275273927130c9bad72a09822aa4723bbdffa2
Status: Image is up to date for technekes/nib:latest
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

## Development

While making changes to `nib` it can be helpful to run a development version to test out commands. One way to accomplish this is by building the image and creating an extra alias for the local copy.

Make a change and build:

```
cd /path/to/technekes/nib
# make some changes
docker build --tag nibdev:latest .
```

Development alias:

```sh
alias nibdev='
  docker run \
    -it \
    --rm \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    -v $HOME/.docker:/root/.docker:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e "DOCKER_HOST_URL=$DOCKER_HOST" \
    nibdev:latest'
```

Try out your command:

```sh
nibdev shell web
```

## Running Specs

This project includes [rspec](http://rspec.info/) and [serverspec](http://serverspec.org/) to help facilitate execution of automated tests. Running the tests is as simple as:

```sh
nib build # the first time (you are using `nib` right?)
nib rspec app
```

## Generating Docs

If you have added a new command you will want to regenerate the [commands document](./docs/commands.md). The following command should get that done:

```sh
docker run \
  --rm \
  -v $PWD:/usr/src/app \
  -w /usr/src/app \
  ruby:alpine bin/update_docs
```

## Contributing

`nib` is work of several contributors. You're encouraged to submit pull requests, propose features and discuss issues.

See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE) for details.
