RSpec.describe command('cd spec/dummy && nibtest codeclimate web --help') do
  its(:stdout) { should match(/Usage: codeclimate COMMAND/) }
  its(:exit_status) { should eq 0 }
end
