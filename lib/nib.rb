require 'nib/version'

require 'core_extensions/hash'
require 'core_extensions/string'
require 'core_extensions/psych'

require 'nib/options'
require 'nib/options/augmenter'
require 'nib/options/parser'

require 'nib/plugins'
require 'nib/plugin'

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
  GEM_ROOT = File.expand_path('..', __dir__)

  module_function

  def installed_plugins
    Nib::Plugins.potential_plugins.map(&:name)
  end

  def available_plugins
    Nib::Plugins.available_plugins.map(&:binstub)
  end

  def load_default_config(command, file_name)
    File.read("#{GEM_ROOT}/config/commands/#{command}/#{file_name}")
  end
end
