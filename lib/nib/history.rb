module Nib::History
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

  def execute
    system('mkdir', '-p', './tmp')
    super
  end

  def command
    <<~COMMAND
      /bin/sh -c \"
        export HISTFILE=./tmp/shell_history
        echo '#{IRBRC}' > /root/.irbrc
        echo '#{PRYRC}' > /root/.pryrc
        #{super}
      \"
    COMMAND
  end
end
