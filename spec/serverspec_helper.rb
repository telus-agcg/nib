require 'serverspec'

set :backend, :exec

NIB_BIN = 'RUBYLIB=/usr/src/app/lib /usr/src/app/bin/nib'.freeze
