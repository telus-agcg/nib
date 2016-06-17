require 'pty'
require 'expect'

RSpec.describe 'console' do
  def tty
    PTY.spawn("cd #{spec_dir} && nibtest console web") do |stdout, stdin, pid|
      stdin.sync = true

      yield(stdout, stdin)

      stdin.puts 'exit'

      Process.waitpid(pid, 0)

      stdin.close
      stdout.close
    end
  end

  context 'rails' do
    let(:spec_dir) { './spec/dummy/rails' }

    context 'binstub console override' do
      let(:binstub) { "#{spec_dir}/bin/console" }

      around(:each) do |example|
        File.rename "#{binstub}.stub", binstub

        example.run

        File.rename binstub, "#{binstub}.stub"
      end

      it 'starts an irb session and accepts input' do
        tty do |stdout, stdin|
          stdout.expect(/irb/, 5) { stdin.puts 'puts "foo"' }

          expect(stdout.gets).to match(/puts \"foo\"/)
        end
      end
    end

    context 'is rails' do
      describe command('cd spec/dummy/rails && nibtest console web') do
        its(:stdout) { should match(/rails/) }
      end
    end
  end

  context 'sinatra' do
    let(:spec_dir) { './spec/dummy/sinatra' }

    context 'has pry' do
      it 'starts a pry session and accepts input' do
        tty do |stdout, stdin|
          stdout.expect(/pry/, 5) { stdin.puts 'puts "foo"' }

          expect(stdout.gets).to match(/puts \"foo\"/)
        end
      end
    end

    context 'has boot' do
      let(:boot_file) { "#{spec_dir}/config/boot.rb" }

      around(:each) do |example|
        File.rename "#{boot_file}.stub", boot_file

        example.run

        File.rename boot_file, "#{boot_file}.stub"
      end

      it 'loads classes required by boot' do
        tty do |stdout, stdin|
          stdout.expect(/pry/, 5) { stdin.puts 'Foo' }

          expect(stdout.gets).to match(/\(main\)> Foo/)
        end
      end
    end
  end
end
