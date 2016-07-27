RSpec.describe Nib::Run do
  let(:service) { 'web' }
  let(:command) { 'puma' }
  let(:options) { {} }

  subject { described_class.new(service, command, options) }

  it 'inserts the --rm arg' do
    expect(subject.script).to match(
      /
        docker-compose
        .*
        run
        .*
        --rm
        .*
        #{service}
        .*
        #{command}
      /x
    )
  end

  describe 'options' do
    context 'without service-ports' do
      let(:options) { { 'service-ports' => false } }

      it 'the service-ports flag is not included' do
        expect(subject.script).to_not include('--service-ports')
      end
    end

    context 'with service-ports' do
      let(:options) { { 'service-ports' => true } }

      it 'the service-ports flag is included' do
        expect(subject.script).to include('--service-ports')
      end
    end
  end
end
