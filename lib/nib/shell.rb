class Nib::Shell
  include Nib::Command
  prepend Nib::History

  SCRIPT = <<-SH.freeze
    if hash bash 2>/dev/null ; then
      bash
    elif hash ash 2>/dev/null ; then
      ash
    else
      sh
    fi
  SH

  private

  def command
    SCRIPT
  end
end
