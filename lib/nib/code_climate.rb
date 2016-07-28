require 'tempfile'

class Nib::CodeClimate
  include Nib::Command

  def self.execute(args)
    # Discard service name because codeclimate is run on local path
    args.shift

    new(nil, args.join(' ')).execute
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
    <<~CONFIG
      version: '2'

      services:
        codeclimate:
          image: codeclimate/codeclimate
          environment:
            - CODECLIMATE_CODE=$PWD
          volumes:
            - $PWD:/code
            - $PWD:$PWD
            - /var/run/docker.sock:/var/run/docker.sock
            - /tmp/cc:/tmp/cc
    CONFIG
  end

  def compose_file
    @compose_file ||= Tempfile.open('compose') do |file|
      file.tap { |f| f.write(config) }
    end
  end
end
