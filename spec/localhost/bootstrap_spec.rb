cmd = 'cd spec/dummy; nibtest bootstrap web'

RSpec.describe 'bootstrap' do
  let(:script_path) { './spec/dummy/script' }

  context 'bootstrap script' do
    context 'exists' do
      let(:script_file) { "#{script_path}/bootstrap" }

      around(:each) do |example|
        File.rename script_file, "#{script_file}.stub"

        example.run

        File.rename "#{script_file}.stub", script_file
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
        its(:stdout) { should match(/hello from bootstrap proper/) }
        its(:exit_status) { should eq 0 }
      end
    end
  end

  %i(before after).each do |hook|
    context "#{hook} script" do
      context 'exists' do
        let(:script_file) { "#{script_path}/bootstrap.#{hook}" }

        around(:each) do |example|
          File.rename "#{script_file}.stub", script_file

          example.run

          File.rename script_file, "#{script_file}.stub"
        end

        describe command(cmd) do
          its(:stdout) { should match(/hello from bootstrap\.#{hook}/) }
          its(:exit_status) { should eq 0 }
        end
      end

      context 'does not exist' do
        describe command(cmd) do
          its(:stdout) { should_not match(/hello from bootstrap\.#{hook}/) }
          its(:exit_status) { should eq 0 }
        end
      end
    end
  end
end
