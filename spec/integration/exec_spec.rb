RSpec.describe 'exec', :running_rails_server do
  describe command("cd spec/dummy/rails; nib exec web 'ps x'") do
    its(:stdout) { should match(%r{\/bin\/rackup\ -p}) }
    its(:exit_status) { should eq 0 }
  end
end
