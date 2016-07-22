require 'yaml'

class Nib::Debug
  attr_reader :service

  def self.execute(_, args)
    new(args.shift).execute
  end

  def initialize(service)
    @service = service
  end

  def execute
    raise 'RUBY_DEBUG_PORT not specified. See "nib debug help"' unless port

    command = "byebug -R #{host}:#{port}"

    puts "Connecting to server via:\n> #{command}"

    script = <<~SCRIPT
      docker-compose \
        run \
        --rm \
        --no-deps \
        #{service} \
        #{command}
    SCRIPT

    system(script)
  end

  private

  def host
    if ENV.key?('DOCKER_HOST_URL') && ENV['DOCKER_HOST_URL'] != ''
      URI.parse(ENV['DOCKER_HOST_URL']).host
    else
      `ip route | awk 'NR==1 {print $3}'`.chomp
    end
  end

  def port
    regexp = %r{
      #{service}:     # start with the service key (web:)
      (?:.|\n)*?      # search through all characters including new lines
      RUBY_DEBUG_PORT # target the env var we defined
      \D*             # expect non-numeric characters (':', ': ', '=', '="')
      (?<port>\d+)    # capture numeric value of the port
    }x                # x allows for multiple lines and comments

    File.read('docker-compose.yml').match(regexp)&.send(:[], :port)
  end
end

