require 'tempfile'

class Nib::Update
  include Nib::Command

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        -f #{compose_file.path} \
        pull
    SCRIPT
  end

  private

  def config
    <<~CONFIG
      version: '2'

      services:
        nib:
          image: technekes/nib:latest
    CONFIG
  end

  def compose_file
    @compose_file ||= Tempfile.open('compose') do |file|
      file.tap { |f| f.write(config) }
    end
  end
end
