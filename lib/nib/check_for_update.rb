require 'net/http'

class Nib::CheckForUpdate
  def self.execute(_, _)
    return if installed == latest

    puts <<~MESSAGE

    An update is available for nib: #{latest}
    Use 'gem update nib' to install the latest version
    MESSAGE
  end

  def self.installed
    Nib::VERSION
  end

  def self.latest
    url = 'https://raw.githubusercontent.com/technekes/nib/latest/VERSION'

    Net::HTTP.get(URI.parse(url)).chomp
  end
end
