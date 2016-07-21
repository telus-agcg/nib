RSpec.configure do |config|
  config.before :suite do
    if ENV['INTEGRATION'] == 'true'
      `docker build --tag nibtest:latest .`
      `cd spec/dummy/rails && docker-compose build`
      `cd spec/dummy/sinatra && docker-compose build`
    end
  end
end
