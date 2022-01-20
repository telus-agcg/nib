require 'pty'
require 'expect'

RSpec.describe 'shell', :interactive do
  let(:command) { "cd #{spec_dir} && #{NIB_BIN} shell web" }

  context 'binstub shell override' do
    let(:spec_dir) { './spec/dummy/rails' }
    let(:binstub) { "#{spec_dir}/bin/shell" }

    around(:each) do |example|
      File.rename "#{binstub}.stub", binstub

      example.run

      File.rename binstub, "#{binstub}.stub"
    end

    it 'is favored' do
      tty(command, true) do |stdout, stdin|
        stdout.expect(/#/, 5) { stdin.puts 'echo "foo"' }

        expect(stdout.gets).to match(/foo/)
      end
    end
  end

  { rails: :bash, sinatra: :ash }.each do |app, shell|
    context shell do
      let(:spec_dir) { "./spec/dummy/#{app}" }

      it 'starts an interactive shell session' do
        tty(command, true) do |stdout, stdin|
          stdout.expect(%r{/usr/src/app}, 5) { stdin.puts 'echo $0' }

          stdout.gets # why extra #gets necessary?
          expect(stdout.gets).to match(/#{shell}/)
        end
      end
    end
  end
end
