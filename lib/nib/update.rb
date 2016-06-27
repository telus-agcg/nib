require 'tempfile'

class Nib::Update
  def self.execute(_, _)
    config = <<~CONFIG
      version: '2'

      services:
        nib:
          image: technekes/nib:latest
    CONFIG

    compose = Tempfile.open('compose') do |file|
      file.tap { |f| f.write(config) }
    end

    script = <<~SCRIPT
      docker-compose \
        -f #{compose.path} \
        pull
    SCRIPT

    system(script)
  end
end

