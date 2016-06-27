require 'tempfile'

class Nib::CodeClimate
  def self.execute(_, _)
    config = <<~CONFIG
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

    compose = Tempfile.open('compose') do |file|
      file.tap { |f| f.write(config) }
    end

    script = <<~SCRIPT
      docker-compose \
        -f #{compose.path} \
        run \
        --rm \
        codeclimate "$@"
    SCRIPT

    system(script)
  end
end
