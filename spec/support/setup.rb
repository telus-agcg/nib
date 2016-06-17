RSpec.configure do |config|
  config.before :suite do
    `docker build --tag nibtest:latest .`
    `cd spec/dummy/rails && docker-compose build`
    `cd spec/dummy/sinatra && docker-compose build`
  end
end
