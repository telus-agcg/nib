DEFAULT_COMPOSE = File.read(
  'spec/fixtures/compose/with_existing_volumes_key.yml'
)

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Nib::History::Compose).to(
      receive(:docker_compose_config).and_return(DEFAULT_COMPOSE)
    )
  end
end
