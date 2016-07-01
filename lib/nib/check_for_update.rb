class Nib::CheckForUpdate
  def self.execute(_, _)
    return if installed == latest

    puts <<~MESSAGE

    An update is available for nib: #{latest}
    Use 'nib update' to pull the latest version
    MESSAGE
  end

  def self.installed
    Nib::VERSION
  end

  def self.latest
    `wget -qO- https://raw.githubusercontent.com/technekes/nib/latest/VERSION`
  end
end
