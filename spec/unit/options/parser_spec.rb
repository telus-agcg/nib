RSpec.describe Nib::Options::Parser do
  let(:raw_options) do
    {
      'd'              => true,
      :d               => true,
      'no-deps'        => false,
      :'no-deps'       => false,
      'service-ports'  => true,
      :'service-ports' => true
    }
  end

  subject { described_class }

  it 'returns a list of enabled switches' do
    expect(subject.parse(raw_options)).to eq('-d --service-ports')
  end
end
