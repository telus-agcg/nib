RSpec.describe command('cd spec/dummy/rails && nibtest dbconsole web') do
  its(:stdout) { should match(/psql/) }
  its(:exit_status) { should eq 0 }
end
