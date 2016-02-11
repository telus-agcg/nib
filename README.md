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
1. Create a virtual machine with `docker-machine`. This will create a VirtualBox based VM with the following attributes.

    | Resource  | Allocation            |
    |-----------|-----------------------|
    | Memory    | 1/2 System Memory     |
    | CPU Count | 1/2 System Core Count |
    | Disk Size | 40 GB                 |

    ```bash
    docker-machine create default \
      --driver virtualbox \
      --virtualbox-memory $(bc -l <<< $(sysctl hw.memsize | awk '{print $2}')/2/1024/1024 | sed "s/\..*$//") \
      --virtualbox-cpu-count $(echo $(bc -l <<< $(sysctl -n hw.ncpu)/2) | sed "s/\..*$//") \
      --virtualbox-disk-size 40000
    ```

    Altertantively you can create a VM based on [xhyve](https://github.com/mist64/xhyve) a [Type 1 hypervisor](https://allysonjulian.com/setting-up-docker-with-xhyve/#creatingthexhyvedockermachine). Follow the instruction for installing the docker-machine xhyve driver [here](https://github.com/zchee/docker-machine-driver-xhyve#install). Then create a VM using that driver like so.

    ```bash
    docker-machine create default \
      --driver xhyve \
      --xhyve-experimental-nfs-share \
      --xhyve-memory-size $(bc -l <<< $(sysctl hw.memsize | awk '{print $2}')/2/1024/1024 | sed "s/\..*$//") \
      --xhyve-cpu-count $(echo $(bc -l <<< $(sysctl -n hw.ncpu)/2) | sed "s/\..*$//") \
      --xhyve-disk-size 40000

    ```

1. Copy the alias below into your shell configuration and provide a value for "YOUR_GIT_KEY" (this will allow the `nib` tool to access git repos on your behalf)

    ```bash
    alias nib='
      docker run \
        -it \
        --rm \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        -v ~/.ssh/#{YOUR_GIT_KEY}:/root/.ssh/id_rsa:ro \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e "DOCKER_HOST_URL=$DOCKER_HOST" \
        technekes/nib'
    ```

1. Start a new bash session and run `nib help` to see the available commands (there may be a brief pause as the image is pulled from docker hub)

## Debugging

nib can help facilitate remote debugging of a running container. In order to make this work there are a couple of steps you'll need to take first.

**Gemfile**
```ruby
gem 'byebug'
```

**config/envrionments/development.rb**
```ruby
require 'byebug/core'
Byebug.start_server '0.0.0.0', (ENV.fetch 'RUBY_DEBUG_PORT', 9005).to_i
```

**docker-compose.yml**
```yml
web:
  ...
  ports:
    - "9005:9005"
  environment:
    - "RUBY_DEBUG_PORT=9005"
```

**.nib**
```json
{
  "services": [
    {
       "name": "web",
       "ruby_debug_port": "9005"
    }
  ]
}
```

Once all of this is in place and the web service is up and running (`nib up`) you can use the `debug` command to attach to the remote debugger:

```sh
nib debug web
```
