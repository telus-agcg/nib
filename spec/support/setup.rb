RSpec.configure do |config|
  config.before :suite do
    `docker build --tag nibtest:latest .`
    `cd spec/dummy && docker-compose build`
  end
end
