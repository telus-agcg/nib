RSpec.describe 'console' do
  pending
end

# TODO: how to test a long running process that expect a tty
# RSpec.describe 'console' do
#   around do |example|
#     # start console
#     cmd = 'cd spec/dummy && nibtest console web'
#     `setsid sh -c 'exec "#{cmd}" <> /dev/tty2 >&0 2>&1'`

#     sleep 5

#     example.run

#     puts `docker ps`
#     # TODO: stop console
#   end

#   context command("docker-compose exec web /bin/bash 'ps x; exit'") do
#     its(:stdout) { should match(/pry/) }
#   end
# end
