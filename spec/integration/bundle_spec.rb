require 'serverspec_helper'

RSpec.describe command("cd spec/dummy/rails && #{NIB_BIN} bundle web -v") do
  its(:stdout) { should match(//) }
  its(:exit_status) { should eq 0 }
end
