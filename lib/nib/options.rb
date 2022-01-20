module Nib::Options
  module_function

  def config
    return @config if @config

    load_with = if YAML.respond_to?(:unsafe_load_file)
      :unsafe_load_file
    else
      :load_file
    end

    @config = YAML.send(load_with, "#{Nib::GEM_ROOT}/config/options.yml")
  end

  def options_for(type, name)
    config.select { |option| option[type].include?(name) }
  end
end
