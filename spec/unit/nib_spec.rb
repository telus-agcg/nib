RSpec.describe Nib do
  subject { described_class }

  let(:plugins) do
    [
      './spec/support/plugin_examples/lib/nib_ruby_plugin.rb'
    ]
  end

  let(:nib_ruby) { './spec/support/plugin_examples/bin/nib-ruby' }

  it 'search gems to find installed plugins' do
    allow(Gem).to receive(:find_files) { plugins }

    expect(subject.installed_plugins).to include('nib-ruby')
  end

  it 'search gems to find available plugins' do
    allow(Gem).to receive(:find_files) { plugins }

    expect(subject.available_plugins).to include(nib_ruby)
  end
end
