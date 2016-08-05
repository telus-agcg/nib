require 'yaml'

class Nib::Debug
  include Nib::Command

  def execute
    raise 'RUBY_DEBUG_PORT not specified. See "nib debug help"' unless port

    puts "Connecting to server via:\n> #{command}"

    super
  end

  private

  def command
    "byebug -R #{host}:#{port}"
  end

  def host
    if ENV.key?('DOCKER_HOST_URL') && ENV['DOCKER_HOST_URL'] != ''
      URI.parse(ENV['DOCKER_HOST_URL']).host
    else
      `ip route | awk 'NR==1 {print $3}'`.chomp
    end
  end

  def compose_file
    @compose_file ||= File.read('docker-compose.yml')
  end

  def port
    regexp = /
      #{service}:     # start with the service key (web:)
      (?:.|\n)*?      # search through all characters including new lines
      RUBY_DEBUG_PORT # target the env var we defined
      \D*             # expect non-numeric characters (':', ': ', '=', '="')
      (?<port>\d+)    # capture numeric value of the port
    /x

    compose_file.match(regexp)&.send(:[], :port)
  end
end
