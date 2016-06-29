class Nib::Shell
  SCRIPT="
    if hash bash 2>/dev/null ; then
      bash
    elif hash ash 2>/dev/null ; then
      ash
    else
      sh
    fi
  "

  def self.execute(_, args)
    service = args.shift
    command = "/bin/sh -c \"#{SCRIPT}\""

    system('mkdir', '-p', "${PWD}/tmp")

    script = <<~SCRIPT
      docker-compose \
        run \
        --rm \
        -e HISTFILE=./tmp/shell_history \
        #{service} \
        #{command}
    SCRIPT

    system(script)
  end
end
