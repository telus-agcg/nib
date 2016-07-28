module Nib::Options::Parser
  module_function

  def parse(raw_options)
    raw_options.symbolize_keys!.map do |name, value|
      option = Nib::Options.options_for(:names, name).first

      send("parse_#{option[:type]}", name, value)
    end.compact.join(' ')
  end

  def parse_switch(name, enabled)
    return unless enabled

    flag_for(name)
  end

  def parse_flag(name, values)
    Array(values).map do |value|
      "#{flag_for(name)} #{value}"
    end
  end

  def flag_for(name)
    name.length == 1 ? "-#{name}" : "--#{name}"
  end
end
