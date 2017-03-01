class Nib::Shell
  include Nib::Command
  prepend Nib::History

  private

  def command
    conditions = %i(zsh bash ash).map do |shell|
      "elif hash #{shell} 2>/dev/null ; then #{shell};"
    end

    conditions                                         # default conditions
      .unshift('if [ -f bin/shell ]; then bin/shell;') # prepend bin/shell
      .push('else sh; fi')                             # add else clause (`sh`)
      .join("\n")
  end
end
