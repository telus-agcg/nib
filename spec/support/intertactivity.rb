module Interactivity
  def tty(command)
    PTY.spawn(command) do |stdout, stdin, pid|
      stdin.sync = true

      yield(stdout, stdin)

      stdin.puts 'exit'

      Process.waitpid(pid, 0)

      stdin.close
      stdout.close
    end
  end
end

RSpec.configure do |c|
  c.include Interactivity, :interactive
end
