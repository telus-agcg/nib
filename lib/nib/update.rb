class Nib::Update
  def self.execute(_, _)
    exec('gem uninstall -ax nib && gem install nib')
  end
end
