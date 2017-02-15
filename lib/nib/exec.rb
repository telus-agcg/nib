class Nib::Exec
  include Nib::Command
  prepend Nib::History

  def script
    @script ||= <<~SCRIPT
      docker-compose \
        exec \
        #{options} \
        #{service} \
        #{command}
    SCRIPT
  end

  def action
    @command.to_s.empty? ? '' : "-c '#{@command}'"
  end

  def command
    "
      if hash bash 2>/dev/null ; then
        bash #{action}
      elif hash ash 2>/dev/null ; then
        ash #{action}
      else
        sh #{action}
      fi
    "
  end
end
