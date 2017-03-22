require 'fileutils'

class Nib::History::Config
  PATH = '/tmp/nib/config'.freeze

  attr_reader :type, :history_command, :host_path

  def initialize(type, history_command)
    @type = type
    @history_command = history_command
    @host_path = "#{ENV['HOME']}/.#{type}"

    FileUtils.mkdir_p PATH
  end

  def container_path
    config_file.path
  end

  private

  def config
    if File.exist?(host_path)
      File.read(host_path)
    else
      Nib.load_default_config(:shell, type)
    end
  end

  def config_file
    @config_file ||= File.open("#{PATH}/#{type}", 'w+') do |file|
      file.write(config)
      file.write(history_command + "\n")
      file
    end
  end
end
