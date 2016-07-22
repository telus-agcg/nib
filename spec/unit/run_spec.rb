RSpec.describe Nib::Run do
  let(:service) { 'web' }
  let(:command) { 'puma' }

  subject { described_class.new(service, command) }

  it 'inserts the --rm arg' do
    expect(subject.script).to match(
      /
        docker-compose
        .*
        run
        .*
        --rm
        .*
        #{service}
        .*
        #{command}
      /x
    )
  end
end
