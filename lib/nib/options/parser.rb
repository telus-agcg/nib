module Nib::Options::Parser
  module_function

  def parse(raw_options)
    raw_options.symbolize_keys!.map do |name, enabled|
      next unless enabled

      name.length == 1 ? "-#{name}" : "--#{name}"
    end.compact.join(' ')
  end
end
