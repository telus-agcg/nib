module Nib::History
  PATH = '/usr/local/history'.freeze

  def self.prepended(base)
    base.instance_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def history_requires_command(value)
      @history_requires_command = value
    end

    def history_requires_command?
      @history_requires_command
    end
  end

  def wrap(executable)
    <<-COMMAND
      /bin/sh -c \"
        export HISTFILE=#{PATH}/shell_history
        cp #{irbrc.container_path} /root/.irbrc 2>/dev/null
        cp #{pryrc.container_path} /root/.pryrc 2>/dev/null
        #{executable}
      \"
    COMMAND
  end

  def command
    return if self.class.history_requires_command? && @command.to_s.empty?

    wrap(super)
  end

  def alternate_compose_file
    "-f #{Compose.new.path}"
  end

  def irbrc
    @irbrc ||= Config.new(
      :irbrc,
      "IRB.conf[:HISTORY_FILE] = '#{PATH}/irb_history'"
    )
  end

  def pryrc
    @pryrc ||= Config.new(
      :pryrc,
      "Pry.config.history.file = '#{PATH}/irb_history'"
    )
  end
end
