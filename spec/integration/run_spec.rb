cmd = "cd spec/dummy/rails && #{NIB_BIN} run web rspec --help"

RSpec.describe command(cmd) do
  its(:stdout) { should match(/Usage: rspec/) }
  its(:exit_status) { should eq 0 }
end
