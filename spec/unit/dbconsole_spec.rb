RSpec.describe 'dbconsole' do
  let(:service) { 'web' }
  let(:command) { './bin/dbconsole -c \'SELECT * FROM foo;\'' }

  subject { Nib::Run.new(service, command) }

  it 'executes ./bin/dbconsole' do
    expect(subject.script).to match(
      %r{
        docker-compose
        .*
        run
        .*
        --rm
        .*
        #{service}
        .*
        \./bin/dbconsole\s-c\s'SELECT\s\*\sFROM\sfoo;'
      }x
    )
  end
end
