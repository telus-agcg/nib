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
          --entrypoint=
          (.|\n)*
          /bin/sh\s-c
          (.|\n)*
          export\sHISTFILE
          (.|\n)*
          bin\/shell
          (.|\n)*
          zsh
          (.|\n)*
          bash
          (.|\n)*
          ash
          (.|\n)*
          sh
          (.|\n)*
          #{service}
        }x
      )
    end
  end
end
