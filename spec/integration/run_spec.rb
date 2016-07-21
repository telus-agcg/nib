RSpec.describe command('cd spec/dummy/rails && nibtest run web rspec --help') do
  its(:stdout) { should match(/Usage: rspec/) }
  its(:exit_status) { should eq 0 }
end
