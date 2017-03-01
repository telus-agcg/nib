RSpec.describe Nib::Run do
  let(:service) { 'web' }
  let(:command) { 'puma' }

  subject { described_class.new(service, command) }

  context 'with a command specified' do
    it 'inserts the --rm arg and includes history' do
      expect(subject.script).to match(
        /
          docker-compose
          .*
          run
          .*
          --rm
          .*
          #{service}
          (.|\n)*
          export\sHISTFILE
          (.|\n)*
          #{command}$
        /x
      )
    end
  end

  context 'without a command specified' do
    let(:command) { nil }

    it 'does not include history' do
      expect(subject.script).to_not include('HISTORY')
    end
  end
end
