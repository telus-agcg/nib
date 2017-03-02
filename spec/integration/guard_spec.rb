RSpec.describe command("cd spec/dummy/rails && #{NIB_BIN} guard web --help") do
  its(:stdout) { should match(/Starts Guard/) }
  its(:exit_status) { should eq 0 }
end
