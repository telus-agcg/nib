class Nib::Console
  include Nib::Command
  prepend Nib::History

  SCRIPT = <<~SH.freeze
    has_pry=false
    has_boot=false
    if hash pry 2>/dev/null ; then
      has_pry=true
    fi
    if [ -f config/boot.rb ]; then
      has_boot=true
    fi
    if [ -f bin/console ]; then
      bin/console
    elif [ -f bin/rails ]; then
      rails console
    elif [ \\$has_boot = true ] && [ \\$has_pry = true ]; then
      pry -r ./config/boot
    elif [ \\$has_boot = true ]; then
      irb -r ./config/boot
    elif [ \\$has_pry = true ]; then
      bundle config console pry
      bundle console
    else
      bundle console
    fi
  SH

  private

  def command
    SCRIPT
  end
end
