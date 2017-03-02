cmd = "cd spec/dummy/rails && #{NIB_BIN} rubocop web --help"

RSpec.describe command(cmd) do
  its(:stdout) { should match(/Usage: rubocop/) }
  its(:exit_status) { should eq 0 }
end
