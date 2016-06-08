RSpec.describe command('cd spec/dummy && nibtest rails web --help') do
  its(:stdout) { should match(/rails new APP_PATH/) }
  its(:exit_status) { should eq 0 }
end
