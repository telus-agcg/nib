RSpec.describe Nib::Shell do
  let(:service) { 'web' }

  subject { described_class.new(service, nil) }

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
