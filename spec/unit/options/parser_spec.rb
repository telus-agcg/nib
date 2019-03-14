RSpec.describe Nib::Options::Parser do
  let(:switch_options) do
    {
      'd'              => true,
      :d               => true,
      'no-deps'        => false,
      :'no-deps'       => false,
      'service-ports'  => true,
      :'service-ports' => true
    }
  end

  let(:flag_options) do
    {
      'name'       => 'banana',
      :name        => 'banana',
      'e'          => %i(FOO=bar RAILS_ENV=development),
      :e           => %i(FOO=bar RAILS_ENV=development),
      'entrypoint' => '/sh',
      :entrypoint  => '/sh'
    }
  end

  subject { described_class }

  context 'switches' do
    it 'returns a list of enabled switches' do
      expect(subject.parse(switch_options)).to eq('-d --service-ports')
    end
  end

  context 'flags' do
    it 'returns a list of flags with their values' do
      expect(subject.parse(flag_options)).to eq(
        '--name banana -e FOO=bar -e RAILS_ENV=development --entrypoint /sh'
      )
    end
  end
end
