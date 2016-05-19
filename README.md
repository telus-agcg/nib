# nib

A tool to aid development in a `docker-compose` environment. Currently supports a workflow where a single `docker-compose.yml` sits over one or more applications. Therefore the `nib` commands must be issued from the working directory of the `docker-compose.yml`

Currently `nib` is tailored towards Ruby/Rails development. Some commands like `nib console` are expecting a Ruby like environment (`rails console` or `pry` etc) however it will fall down to a script/console (executable file) where a custom script can be defined. Other commands like `nib rake` or `nib guard` are clearly meant for Ruby developers.

## Usage

`nib` can ultimately be used as a replacement for `docker-compose` because it will delegate all commands it does not recognize to `docker-compose`. From there you can take advantage of the additional commands with a similar workflow. For example:

```sh
> nib shell web
root@fd80bbc4ab5a:/usr/src/app#
```

Will start up a container for the `web` service and drop you into an interactive shell session (bash, ash or sh). In addition nib will hook up a history file for your shell session (relative to the current project). This means that you will be able to use the history (up arrow) in future shell sessions, something that is not available with vanilla docker/docker-compose!

For additional commands review the help system.

```sh
> nib help
Usage: nib COMMAND [OPTIONS] [arg...]

Run docker/compose commands on apps relative to the current directory

Options:
  -h, --help      Print usage
      --version   Print version information

Commands:
    attach        Attach an interactive shell session to a running container
    bundle        Run bundle for the given service
    bootstrap     Runs the bootstrap script for the requested app (or all apps if 'apps' is specified)
    console       Start a REPL session for the given service
    debug         Connect to a running byebug server for a given service
    rails         Run the rails command for the given service
    rake          Run the rake command for the given service
    restart       Restart a running container
    rspec         Runs the rspec command for the given service
    run           Wraps normal 'docker-compose run' to ensure that --rm is always passed
    shell         Start a shell session in a one-off service container
    update        Download the latest version of the nib tool

Run 'nib COMMAND --help' for more information on a command.

Note:
  Unrecognized commands will be delegate to docker-compose

  For example the following are equivalent:
    nib start
    docker-compose start
```

## Install

1. Install the [dockertoolbox](https://www.docker.com/docker-toolbox)
1. Create a virtual machine with `docker-machine`. For better performance in file sharing with the host, automated dnsmasq support (*.docker) and filesystem events we recommend trying [dinghy](https://github.com/codekitchen/dinghy).

    Dinghy can be installed via a brew tap (assumes you already have [Homebrew](http://brew.sh/) installed).

    ```sh
    brew tap codekitchen/dinghy
    brew install dinghy
    ```

    Now create a new docker machine using the dinghy cli.

    ```sh
    dinghy create \
      --provider virtualbox \
      --memory=$(bc -l <<< $(sysctl hw.memsize | awk '{print $2}')/2/1024/1024 | sed "s/\..*$//") \
      --cpus=$(echo $(bc -l <<< $(sysctl -n hw.ncpu)/2) | sed "s/\..*$//") \
      --disk=40000
    ```

    This will create a VirtualBox based VM with the following attributes.

    | Resource  | Allocation            |
    |-----------|-----------------------|
    | Memory    | 1/2 System Memory     |
    | CPU Count | 1/2 System Core Count |
    | Disk Size | 40 GB                 |


    This creates a new docker-machine by the name of `dinghy`. In order to have the additional services started (nfs, dnsmasq etc) you will need to use the dinghy cli to start the machine.

    ```bash
    dinghy up
    # provide password (required by nfs service)
    ```

    In order to point your docker client at the new machine you'll need to set some environment variables.

    ```bash
    eval $(dinghy shellinit)
    ```

    This will need to be executed per shell session. If you're using docker regularly you should consider adding this to your profile file of choice (`.bashrc`, `.zshrc` etc).

1. Copy the alias below into your shell configuration and provide a value for "YOUR_GIT_KEY" (this will allow the `nib` tool to access git repos on your behalf)
1. The most convenient way to use nib is by creating an alias or shell function. Here is an alias you can add to your profile that will make `nib` appear as a command. Note, in order for the `nib update` command (download the latest version) to work

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

Tell nib what port you are using by adding a configuration file (`.nib` JSON) specifying the service name and port.

```json
// .nib
{
  "services": [
    {
       "name": "web",
       "ruby_debug_port": "3001"
    }
  ]
}
```

Once all of this is in place and the web service is up and running (`nib up`) you can use the `debug` command to attach to the remote debugger.

```sh
> nib debug web
```

## Development

While making changes to `nib` it can be helpful to run a development version to test out commands (what, no tests?!). One way to accomplish this is by building the image and creating an extra alias for the local copy.

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

## Contributing

`nib` is work of several contributors. You're encouraged to submit pull requests, propose features and discuss issues.

See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE) for details.
