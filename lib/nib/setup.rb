class Nib::Setup
  include Nib::Command

  SCRIPT = <<~SH.freeze
    if [ -f bin/setup.before ]; then
      bin/setup.before
    fi

    if [ -f bin/setup ]; then
      bin/setup
    else
      gem install bundler
      bundle install --jobs 4
    fi

    if [ -f bin/setup.after ]; then
      bin/setup.after
    fi
  SH

  private

  def command
    "/bin/sh -c \"#{SCRIPT}\""
  end
end
