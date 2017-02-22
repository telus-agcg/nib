RSpec.describe Nib::Console do
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
          bin/console
          (.|\n)*
          rails\sconsole
          (.|\n)*
          pry\s-r\s./config/boot
          (.|\n)*
          irb\s-r\s./config/boot
          (.|\n)*
          bundle\sconsole
        }x
      )
    end
  end
end
