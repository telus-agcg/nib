cmd = 'docker run --rm --entrypoint=ash nibdev -c "which yaml2json"'

RSpec.describe command(cmd) do
  its(:stdout) { should match(/\/usr\/local\/bin\/yaml2json/) }
  its(:exit_status) { should eq 0 }
end
