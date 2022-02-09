module Nib::Options
  module_function

  def config
    return @config if @config

    @config = Psych.flexible_load_file("#{Nib::GEM_ROOT}/config/options.yml")
  end

  def options_for(type, name)
    config.select { |option| option[type].include?(name) }
  end
end
