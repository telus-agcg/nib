class Nib::Console
  include Nib::Command

  IRBRC = <<~'IRB'.freeze
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

  PRYRC = 'Pry.config.history.file = \"#{Dir.pwd}/tmp/irb_history\"'.freeze

  SCRIPT = <<~SH.freeze
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
    elif [ -f bin/rails ]; then
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
