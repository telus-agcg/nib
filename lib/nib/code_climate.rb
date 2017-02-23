require 'tempfile'

class Nib::CodeClimate
  include Nib::Command

  def self.execute(args, options = '')
    # Discard service name because codeclimate is run on local path
    args.shift

    new(nil, args.join(' '), options).execute
  end

  def script
    @script ||= <<-SCRIPT
      docker run \
        --interactive \
        --tty \
        --rm \
        --env CODECLIMATE_CODE="$PWD" \
        --volume "$PWD":/code \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume /tmp/cc:/tmp/cc \
        codeclimate/codeclimate #{command || 'help'}
    SCRIPT
  end
end
