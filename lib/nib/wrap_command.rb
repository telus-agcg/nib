class Nib::WrapCommand
  def self.execute(_, args)
    service = args.shift
    command = args.join(' ')

    script = <<~SCRIPT
      docker-compose \
        run \
        --rm \
        #{service} \
        #{command}
    SCRIPT

    system(script)
  end
end
