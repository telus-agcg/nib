RSpec.describe 'attach' do
  pending
end

# TODO: finish this when #54 is completed

# script=<<~COMMAND
#   cd spec/dummy
#   docker-compose up -d
#   nibtest attach web 'ps x; exit'
# COMMAND
# RSpec.describe command(script) do
#   its(:stdout) { should match(/\/bin\/rackup\ -p/) }
#   its(:exit_status) { should eq 0 }
# end
