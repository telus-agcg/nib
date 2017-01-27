require 'pty'
require 'expect'

RSpec.describe 'shell', :interactive do
  let(:command) { "cd #{spec_dir} && nib shell web" }

  { rails: :bash, sinatra: :ash }.each do |app, shell|
    context shell do
      let(:spec_dir) { "./spec/dummy/#{app}" }

      it 'starts an interactive shell session' do
        tty(command, true) do |stdout, stdin|
          stdout.expect(%r{\/usr\/src\/app}, 5) { stdin.puts 'echo $0' }

          stdout.gets # why extra #gets necessary?
          expect(stdout.gets).to match(/#{shell}/)
        end
      end
    end
  end
end
