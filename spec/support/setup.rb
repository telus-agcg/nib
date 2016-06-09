RSpec.configure do |config|
  config.before :suite do
    `docker build --tag nibtest:latest .`
  end
end
