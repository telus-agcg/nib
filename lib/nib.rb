require 'nib/version'

require 'core_extensions/hash'

require 'nib/options'
require 'nib/options/augmenter'
require 'nib/options/parser'

require 'nib/command'
require 'nib/history'
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

  def load_config(command, file_name)
    File.read("#{GEM_ROOT}/config/commands/#{command}/#{file_name}")
  end

  def load_default_config(command, file_name)
    load_config(command, file_name)
  end
end
