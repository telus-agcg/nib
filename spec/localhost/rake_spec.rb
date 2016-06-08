RSpec.describe command('cd spec/dummy && nibtest rake web --help') do
  its(:stdout) { should match(/rake \[-f rakefile\]/) }
  its(:exit_status) { should eq 0 }
end
