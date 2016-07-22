RSpec.describe Nib::Run do
  subject { described_class }

  it 'inserts the --rm arg' do
    expect(subject).to receive(:system).with(/--rm/)

    subject.execute(nil, [])
  end
end
