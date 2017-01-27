RSpec.shared_context 'running rails server', :running_rails_server do
  around(:each) do |example|
    `
      cd spec/dummy/rails
      docker-compose up -d
    `

    example.run

    `
      cd spec/dummy/rails
      docker-compose stop
      docker-compose rm -f
    `
  end
end
