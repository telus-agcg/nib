class Nib::Console
  IRBRC=<<~'IRB'
    require \"rubygems\"
    require \"irb/completion\"
    require \"irb/ext/save-history\"
    # irb configuration
    IRB.conf[:PROMPT_MODE] = :SIMPLE
    IRB.conf[:AUTO_INDENT] = true
    # irb history
    IRB.conf[:EVAL_HISTORY] = 10
    IRB.conf[:SAVE_HISTORY] = 1000
    IRB.conf[:HISTORY_FILE] = \"#{Dir.pwd}/tmp/irb_history\"
  IRB

  PRYRC='Pry.config.history.file = \"#{Dir.pwd}/tmp/irb_history\"'

  SCRIPT=<<~SH
    echo '#{IRBRC}' > /root/.irbrc
    echo '#{PRYRC}' > /root/.pryrc
    has_pry=false
    has_boot=false
    if hash pry 2>/dev/null ; then
      has_pry=true
    fi
    if [ -f config/boot.rb ]; then
      has_boot=true
    fi
    if [ -f bin/console ]; then
      bin/console
    elif hash rails 2>/dev/null ; then
      rails console
    elif [ \\$has_boot = true ] && [ \\$has_pry = true ]; then
      pry -r ./config/boot
    elif [ \\$has_boot = true ]; then
      irb -r ./config/boot
    elif [ \\$has_pry = true ]; then
      bundle config console pry
      bundle console
    else
      bundle console
    fi
  SH

  def self.execute(_, args)
    service = args.shift
    command = "/bin/sh -c \"#{SCRIPT}\""

    system('mkdir', '-p', './tmp')

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
