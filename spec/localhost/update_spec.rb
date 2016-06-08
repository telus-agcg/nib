RSpec.describe command('cd spec/dummy && nibtest update') do
  its(:stdout) { should match(/Pulling nib/) }
  its(:exit_status) { should eq 0 }
end
