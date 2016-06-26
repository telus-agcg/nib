class Nib::Exec
  def self.execute(_, args)
    service = args.shift
    command = args.join(' ')

    action = command.empty? ? '' : "-c \"#{command}\""

    entrypoint = "
      if hash bash 2>/dev/null ; then
        bash #{action}
      elif hash ash 2>/dev/null ; then
        ash #{action}
      else
        sh #{action}
      fi
    "

    script = <<~SCRIPT
      docker-compose \
        exec \
        #{service} \
        /bin/sh -c "#{entrypoint}"
    SCRIPT

    system(script)
  end
end
