require 'pty'

RSpec.describe 'console' do
  def tty
    PTY.spawn('cd spec/dummy && nibtest console web') do |stdout, stdin, pid|
      stdout.eof?

      yield(stdout, stdin)

      stdin.puts 'exit'

      Process.waitpid(pid, 0)

      stdin.close
      stdout.close
    end
  end

  it 'starts a pry session and accepts input' do
    tty do |stdout, stdin|
      # ideally we do not have to write a message at all, we simply want to
      # check for a prompt. however if we do not perform a #puts here then
      # stdout.gets hangs indefinitely.
      stdin.puts 'puts "foo"'

      expect(stdout.gets).to match(/puts \"foo\"/)
      expect(stdout.gets).to match(/pry\(main\)>/)
    end
  end
end
