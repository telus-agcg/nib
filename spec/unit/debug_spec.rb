RSpec.describe Nib::Debug do
  let(:service) { 'web' }

  subject { described_class.new(service, nil, '--no-deps') }

  before do
    allow(subject).to receive(:compose_file) do
      File.read('spec/dummy/rails/docker-compose.yml')
    end
  end

  describe '#script' do
    it 'runs a container with bybug on the appropriate port' do
      expect(subject.script).to match(
        /
          docker-compose
          .*
          run
          .*
          --rm
          .*
          --no-deps
          .*
          #{service}
          .*
          byebug\s-R\s
          ([0-9]{1,3}\.){3}[0-9]{1,3}   # host ip address
          :3001$                        # ruby debug port
        /x
      )
    end
  end
end
