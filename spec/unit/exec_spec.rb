RSpec.describe Nib::Exec do
  let(:service) { 'web' }

  let(:matcher) do
    %r{
      docker-compose
      .*
      exec
      .*
      #{service}
      .*
      /bin/sh\s-c\s
      (.|\n)*
      #{command}
    }x
  end

  subject { described_class.new(service, command) }

  context 'without command' do
    let(:command) { nil }

    it 'a shell session is started' do
      expect(subject.script).to match(matcher)
    end
  end

  context 'with command' do
    let(:command) { 'ls' }

    it 'the command is executed' do
      expect(subject.script).to match(matcher)
    end
  end
end
