class Nib::CheckForUpdate
  def self.execute(_, _)
    return if installed == latest

    puts <<~MESSAGE

    An update avaiable is available for nib: #{latest}
    Use 'nib update' to pull the latest version
    MESSAGE
  end

  def self.installed
    Nib::VERSION
  end

  def self.latest
    regexp = %r{
      VERSION          # start with the VERSION constant
      \D+              # expect non-numeric characters (" = '")
      (?<version>[\d\.]+) # capture numeric and periods
    }x                 # x allows for multiple lines and comments

    script = <<-SCRIPT
      wget \
        -qO- \
        https://raw.githubusercontent.com/technekes/nib/latest/lib/nib/version.rb
    SCRIPT

    `#{script}`.match(regexp)&.send(:[], :version)
  end
end
