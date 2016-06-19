cmd = 'cd spec/dummy/rails; nibtest setup web'

RSpec.describe 'setup' do
  let(:bin_path) { './spec/dummy/rails/bin' }

  context 'setup binstub' do
    context 'exists' do
      let(:binstub) { "#{bin_path}/setup" }

      around(:each) do |example|
        File.rename binstub, "#{binstub}.stub"

        example.run

        File.rename "#{binstub}.stub", binstub
      end

      describe command(cmd) do
        its(:stdout) do
          should match(/Fetching: bundler-/)
          should match(/Bundle complete!/)
          should match(/No Rakefile found/)
        end

        its(:exit_status) { should eq 0 }
      end
    end

    context 'does not exist' do
      describe command(cmd) do
        its(:stdout) { should match(/hello from setup proper/) }
        its(:exit_status) { should eq 0 }
      end
    end
  end

  %i(before after).each do |hook|
    context "#{hook} binstub" do
      context 'exists' do
        let(:binstub) { "#{bin_path}/setup.#{hook}" }

        around(:each) do |example|
          File.rename "#{binstub}.stub", binstub

          example.run

          File.rename binstub, "#{binstub}.stub"
        end

        describe command(cmd) do
          its(:stdout) { should match(/hello from setup\.#{hook}/) }
          its(:exit_status) { should eq 0 }
        end
      end

      context 'does not exist' do
        describe command(cmd) do
          its(:stdout) { should_not match(/hello from setup\.#{hook}/) }
          its(:exit_status) { should eq 0 }
        end
      end
    end
  end
end
