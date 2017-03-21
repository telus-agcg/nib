RSpec.describe Nib::History::Compose do
  let(:history_config) { 'nib_history:/usr/local/history' }

  before do
    allow(subject).to receive(:docker_compose_config) do
      fixture_name = self.class.description.tr(' ', '_')

      File.read("./spec/fixtures/compose/#{fixture_name}.yml")
    end
  end

  context 'with existing volumes key' do
    it 'adds the history volume' do
      subject.config['services'].each do |_, definition|
        expect(definition['volumes']).to include(history_config)
      end
    end
  end

  context 'without existing volumes key' do
    it 'adds the history volume' do
      subject.config['services'].each do |_, definition|
        expect(definition['volumes']).to include(history_config)
      end
    end
  end

  context 'with a literal dollar' do
    it 'escapes with double dollar' do
      expect(subject.config.to_s).to include('$$')
    end
  end
end
