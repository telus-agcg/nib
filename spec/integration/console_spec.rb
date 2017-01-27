require 'pty'
require 'expect'

RSpec.describe 'console', :interactive do
  let(:command) { "cd #{spec_dir} && nib console web" }

  context 'rails' do
    let(:spec_dir) { './spec/dummy/rails' }
    let(:binstub) { "#{spec_dir}/bin/#{type}" }

    around(:each) do |example|
      File.rename "#{binstub}.stub", binstub

      example.run

      File.rename binstub, "#{binstub}.stub"
    end

    context 'binstub console override' do
      let(:type) { :console }

      it 'starts an irb session and accepts input' do
        tty(command, true) do |stdout, stdin|
          stdout.expect(/irb/, 5) { stdin.puts 'puts "foo"' }

          expect(stdout.gets).to match(/puts \"foo\"/)
        end
      end
    end

    context 'is rails' do
      let(:type) { :rails }

      it 'detects rails and starts an interactive rails console' do
        tty(command, true) do |stdout, stdin|
          stdout.expect(/rails/, 5) { stdin.puts 'puts "foo"' }

          expect(stdout.gets).to match(/puts \"foo\"/)
        end
      end
    end
  end

  context 'sinatra' do
    let(:spec_dir) { './spec/dummy/sinatra' }

    context 'has pry' do
      it 'starts a pry session and accepts input' do
        tty(command, true) do |stdout, stdin|
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
        tty(command, true) do |stdout, stdin|
          stdout.expect(/pry/, 5) { stdin.puts 'Foo' }

          expect(stdout.gets).to match(/Foo/)
        end
      end
    end
  end
end
