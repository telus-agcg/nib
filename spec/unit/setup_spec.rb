RSpec.describe Nib::Setup do
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
          bin/setup\.before
          (.|\n)*
          bin/setup
          (.|\n)*
          gem\sinstall\sbundler
          (.|\n)*
          bundle\sinstall\s--jobs\s4
          (.|\n)*
          bin/setup\.after
        }x
      )
    end
  end
end
