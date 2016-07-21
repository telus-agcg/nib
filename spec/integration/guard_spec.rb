RSpec.describe command('cd spec/dummy/rails && nibtest guard web --help') do
  its(:stdout) { should match(/Starts Guard/) }
  its(:exit_status) { should eq 0 }
end
