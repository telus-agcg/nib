RSpec.describe Nib::CheckForUpdate do
  subject { described_class }

  before do
    allow(described_class).to receive(:latest).and_return(latest)
  end

  context 'current' do
    let(:latest) { Nib::VERSION }

    it 'does not output a message' do
      expect($stdout).to_not receive(:puts)

      subject.execute(nil, nil)
    end
  end

  context 'outdated' do
    let(:latest) { '100.0.0' }

    it 'does not output a message' do
      expect($stdout).to receive(:puts).with(/An update.*#{latest}/)

      subject.execute(nil, nil)
    end
  end
end
