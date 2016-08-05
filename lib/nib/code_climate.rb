require 'tempfile'

class Nib::CodeClimate
  include Nib::Command

  def self.execute(args, options = '')
    # Discard service name because codeclimate is run on local path
    args.shift

    new(nil, args.join(' '), options).execute
  end

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        -f #{compose_file.path} \
        run \
        --rm \
        codeclimate \
        #{command}
    SCRIPT
  end

  private

  def config
    @config ||= Nib.load_config(:codeclimate, 'docker-compose.yml')
  end

  def compose_file
    @compose_file ||= Tempfile.open('compose') do |file|
      file.tap { |f| f.write(config) }
    end
  end
end
