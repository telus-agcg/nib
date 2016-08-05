class Nib::Shell
  include Nib::Command

  SCRIPT = <<~SH.freeze
    if hash bash 2>/dev/null ; then
      bash
    elif hash ash 2>/dev/null ; then
      ash
    else
      sh
    fi
  SH

  def execute
    system('mkdir', '-p', './tmp')
    super
  end

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        run \
        --rm \
        -e HISTFILE=./tmp/shell_history \
        #{service} \
        #{command}
    SCRIPT
  end

  private

  def command
    "/bin/sh -c \"#{SCRIPT}\""
  end
end
