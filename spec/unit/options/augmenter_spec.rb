RSpec.describe Nib::Options::Augmenter do
  let(:command_name) { :run }
  let(:command)      { double('command', name: command_name) }

  subject { described_class }

  it 'adds switches to a command' do
    allow(command).to receive(:flag).at_least(1)
    expect(command).to receive(:switch).at_least(1)

    subject.augment(command)
  end

  it 'adds flags to a command' do
    allow(command).to receive(:switch).at_least(1)
    expect(command).to receive(:flag).at_least(1)

    subject.augment(command)
  end
end
