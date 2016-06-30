require 'expect'

RSpec.describe 'debug', :interactive, :running_rails_server do
  let(:spec_dir) { './spec/dummy/rails' }
  let(:command)  { "pwd && cd #{spec_dir} && nibtest debug web" }

  it 'connects to a running debug server' do
    tty(command) do |stdout, _|
      output = stdout.expect(/Connected/, 5)

      expect(output.first).to match(/Connecting to byebug server/)
    end
  end
end
