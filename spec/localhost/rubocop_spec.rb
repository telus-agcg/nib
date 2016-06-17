RSpec.describe command('cd spec/dummy/rails && nibtest rubocop web --help') do
  its(:stdout) { should match(/Usage: rubocop/) }
  its(:exit_status) { should eq 0 }
end
