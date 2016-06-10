# Supported Commands

The following commands are available:

Name | Description
---- | -----------
`bootstrap` | Runs the bootstrap script for the requested app (or all apps if 'apps' is specified)
`bundle` | Run bundle for the given service
`codeclimate` | Run codeclimate againt the current working directory
`console` | Start a REPL session for the given service
`debug` | Connect to a running byebug server for a given service
`exec` | Attach an interactive shell session to a running container
`guard` | Run the guard command for the given service
`rails` | Run the rails command for the given service
`rake` | Run the rake command for the given service
`rspec` | Runs the rspec command for the given service
`rubocop` | Runs the rubocop command for the given service
`run` | Wraps normal 'docker-compose run' to ensure that --rm is always passed
`shell` | Start a shell session in a one-off service container
`update` | Download the latest version of the nib tool
