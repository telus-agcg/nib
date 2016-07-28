RSpec.describe Nib::Options do
  subject { described_class }

  it 'finds options by name' do
    options = subject.options_for(:names, :'service-ports')

    options.each do |option|
      expect(option[:names]).to include(:'service-ports')
    end
  end

  it 'finds options for commands by name' do
    options = subject.options_for(:commands, :run)

    options.each do |option|
      expect(option[:commands]).to include(:run)
    end
  end
end
