RSpec.describe Nib::Shell do
  let(:service) { 'web' }

  subject { described_class.new(service, nil) }

  context 'temporary directory' do
    before do
      allow(subject).to receive(:exec).with(/docker-compose/)
    end

    it 'is created to store history' do
      expect(subject).to receive(:system).with('mkdir', '-p', './tmp')

      subject.execute
    end
  end

  describe '#script' do
    it 'runs a container and chooses a console' do
      expect(subject.script).to match(
        %r{
          docker-compose
          .*
          run
          .*
          --rm
          .*
          #{service}
          .*
          /bin/sh\s-c
          (.|\n)*
          bash
          (.|\n)*
          ash
          (.|\n)*
          sh
        }x
      )
    end
  end
end
