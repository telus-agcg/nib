RSpec.describe command('cd spec/dummy/rails && nib rubocop web --help') do
  its(:stdout) { should match(/Usage: rubocop/) }
  its(:exit_status) { should eq 0 }
end
