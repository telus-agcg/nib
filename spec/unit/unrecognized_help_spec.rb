RSpec.describe Nib::UnrecognizedHelp do
  subject { described_class }

  it 'outputs a message about docker-compose delegation' do
    expect($stdout).to receive(:puts).with(/Unrecognized.*docker-compose/)

    subject.execute(nil, nil)
  end
end
