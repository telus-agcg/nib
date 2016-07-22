RSpec.describe Nib::Update do
  subject { described_class.new(nil, []) }

  before do
    allow(subject).to receive(:system)
  end

  it 'runs a docker-compose pull' do
    expect(subject.script).to match(
      %r{
        docker-compose
        .*
        -f\s/tmp/compose
        .*
        pull
      }x
    )
  end
end
