require 'tempfile'
require 'tmpdir'

class Nib::History::Compose
  attr_reader :dir, :volume_name

  def initialize
    @volume_name = 'nib_history'
    @dir = "#{Dir.tmpdir}/#{Dir.pwd.split('/').last}"

    FileUtils.mkdir_p(dir)
  end

  def path
    file.path
  end

  def config
    original_config
      .merge('services' => services_config)
      .merge('volumes' => volumes_config)
  end

  private

  def docker_compose_config
    @docker_compose_config ||= `docker-compose config`
  end

  def original_config
    @original_config ||= Psych.flexible_load(
      docker_compose_config.gsub(/\$/, '$$')
    )
  end

  def file
    @file ||= Tempfile.open('compose', dir) do |compose|
      compose.write(config.to_yaml)
      compose
    end
  end

  def services_config
    Services.new(volume_name, original_config['services']).config
  end

  def volumes_config
    Volumes.new(volume_name, original_config['volumes']).config
  end

  class Services
    attr_reader :original_config, :volume_name

    def initialize(volume_name, original_config)
      @original_config = original_config
      @volume_name = volume_name
    end

    def config
      original_config.transform_values do |definition|
        Service.new(volume_name, definition).config
      end
    end
  end

  class Service
    attr_reader :original_config, :volume_name

    def initialize(volume_name, original_config)
      @original_config = original_config
      @volume_name = volume_name
    end

    def config
      original_config.merge(
        'volumes' => volumes_config | [history_config, rc_config]
      )
    end

    private

    def volumes_config
      original_config['volumes'] || []
    end

    def history_config
      "#{volume_name}:#{Nib::History::PATH}"
    end

    def rc_config
      "#{Nib::History::Config::PATH}:#{Nib::History::Config::PATH}"
    end
  end

  class Volumes
    attr_reader :original_config, :volume_name

    def initialize(volume_name, original_config = nil)
      @original_config = original_config || {}
      @volume_name = volume_name
    end

    def config
      original_config.merge(volume_name => nil)
    end
  end
end
