class Nib::Setup
  SCRIPT="
    if [ -f bin/setup.before ]; then
      bin/setup.before
    fi

    if [ -f bin/setup ]; then
      bin/setup
    else
      gem install bundler
      bundle install --jobs 4
    fi

    if [ -f bin/setup.after ]; then
      bin/setup.after
    fi
  "

  def self.execute(_, args)
    service = args.shift
    command = "/bin/sh -c \"#{SCRIPT}\""

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
