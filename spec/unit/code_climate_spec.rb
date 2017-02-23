RSpec.describe Nib::CodeClimate do
  let(:service) { '' }
  let(:command) { 'analyze' }

  subject { described_class.new(service, command) }

  before do
    allow(subject).to receive(:exec)
  end

  it 'runs the codeclimate docker image' do
    expect(subject.script).to match(
      %r{
        .*
        docker\srun
        .*
        codeclimate\/codeclimate
        .*
        analyze
      }x
    )
  end
end
