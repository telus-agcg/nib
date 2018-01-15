require 'nib/version'

require 'core_extensions/hash'

require 'nib/options'
require 'nib/options/augmenter'
require 'nib/options/parser'

require 'nib/command'
require 'nib/history'
require 'nib/history/compose'
require 'nib/history/config'
require 'nib/check_for_update'
require 'nib/unrecognized_help'
require 'nib/code_climate'
require 'nib/console'
require 'nib/debug'
require 'nib/exec'
require 'nib/run'
require 'nib/setup'
require 'nib/shell'
require 'nib/update'

module Nib
  GEM_ROOT = File.expand_path('../..', __FILE__)

  module_function

  def available_plugins
    Gem.find_files('nib*_plugin.rb').sort.map do |plugin_path|
      name = File.basename plugin_path, '_plugin.rb'

      require plugin_path

      next unless const_for(name).applies?

      plugin_base_path = plugin_path[0..-"/lib/#{name}_plugin.rb".length]

      "#{plugin_base_path}bin/#{name.tr('_', '-')}"
    end.compact
  end

  def const_for(name)
    Nib.const_get(name.split('_').map(&:capitalize).join('::'))
  end

  def load_default_config(command, file_name)
    File.read("#{GEM_ROOT}/config/commands/#{command}/#{file_name}")
  end
end
