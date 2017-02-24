DEFAULT_COMPOSE = YAML.load_file(
  'spec/fixtures/compose/with_existing_volumes_key.yml'
)

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Nib::History::Compose).to receive(:original_config) do
      DEFAULT_COMPOSE
    end
  end
end
