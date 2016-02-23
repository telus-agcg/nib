# nib

A tool to aid development in a `docker-compose` environment. Currently supports a workflow where a single `docker-compose.yml` sits over one or more applications.

The `nib` commands must be issued from the working directory of the `docker-compose.yml`

In addition to a `docker-compose.yml` the `nib` tool expects a `.nib` JSON file that lists application level services available within `docker-compose.yml` with the following format:

```json
{
  "services": [
    {
       "name": "my_app_service_name",
       "ruby_debug_port": "3001"
    }
  ]
}
```

## Install

1. Install the [dockertoolbox](https://www.docker.com/docker-toolbox)
1. Create a virtual machine with `docker-machine`. For better performance in file sharing with the host, automated dnsmasq support (*.docker) and filesystem events we recommend trying [dinghy](https://github.com/codekitchen/dinghy).

    Dinghy can be installed via a brew tap (assumes you already have [Homebrew](http://brew.sh/) installed).

    ```bash
    brew tap codekitchen/dinghy
    brew install dinghy
    ```

    Now create a new docker machine using the dinghy cli.

    ```bash
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

    ```bash
    alias nib='
      docker run \
        -it \
        --rm \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        -v ~/.docker/config.json:/root/.docker/config.json:ro \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e "DOCKER_HOST_URL=$DOCKER_HOST" \
        technekes/nib'
    ```

1. Start a new bash session and run `nib help` to see the available commands (there may be a brief pause as the image is pulled from docker hub)

## Updates

To get the latest version of `nib` use the `update` command. This just pulls the latest version of `technekes/nib:latest` from the Docker Hub. NOTE: This repo is currently private and requires you to be a member of the Technekes Organization on the Docker Hub and that you have logged in on your local machine with `docker login`.

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

Tell nib what port you are using.

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
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e "DOCKER_HOST_URL=$DOCKER_HOST" \
    nibdev:latest'
```

Try out your command:

```sh
nibdev shell web
```
