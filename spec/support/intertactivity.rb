module Interactivity
  def tty(command, signal = 'SIGTERM')
    PTY.spawn(command) do |stdout, stdin, pid|
      stdin.sync = true

      yield(stdout, stdin)

      Process.kill(signal, pid) rescue Errno::ESRCH
      Process.waitpid(pid, 0)

      stdin.close
      stdout.close
    end
  end
end

RSpec.configure do |c|
  c.include Interactivity, :interactive
end
