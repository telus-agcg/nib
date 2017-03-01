class Nib::Shell
  include Nib::Command
  prepend Nib::History

  def command
    conditions = %i(zsh bash ash).map do |shell|
      "elif hash #{shell} 2>/dev/null ; then #{shell};"
    end

    conditions             # default conditions
      .push('else sh; fi') # add else clause (`sh`)
      .join("\n")[2..-1]   # strip off preceeding `el`
  end
end
