module Nib::Options::Augmenter
  module_function

  def augment(command)
    Nib::Options.options_for(:commands, command.name).each do |option|
      command.send(
        option[:type],
        option[:names],
        option[:options]
      )
    end
  end
end
