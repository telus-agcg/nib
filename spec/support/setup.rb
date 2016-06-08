RSpec.configure do |config|
  config.before :suite do
    system('docker build --tag nibtest:latest .')
  end
end
