require 'net/http'

class Nib::CheckForUpdate
  def self.execute(_, _)
    return if installed == latest

    puts <<-MESSAGE.strip_heredoc

      An update is available for nib: #{latest}
      Use 'nib update' to install the latest version
    MESSAGE
  end

  def self.installed
    Nib::VERSION
  end

  def self.latest
    url = 'https://raw.githubusercontent.com/telus-agcg/nib/master/VERSION'

    Net::HTTP.get(URI.parse(url))
  end
end
