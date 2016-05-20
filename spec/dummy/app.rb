require 'rails'
require 'action_controller/railtie'

require 'byebug'
require 'byebug/core'

class MyApp < Rails::Application
  routes.append do
    get '/hello/world' => 'hello#world'
  end

  config.middleware.delete 'Rack::Lock'
  config.middleware.delete 'ActionDispatch::Flash'
  config.middleware.delete 'ActionDispatch::BestStandardsSupport'

  config.eager_load = false
  config.secret_key_base = ENV['SECRET_KEY_BASE']
  config.log_level = :info

  Byebug.start_server '0.0.0.0', (ENV.fetch 'RUBY_DEBUG_PORT', 3001).to_i
end

class HelloController < ActionController::Base
  def world
    byebug
    render text: 'Hello world!'
  end
end

MyApp.initialize!
