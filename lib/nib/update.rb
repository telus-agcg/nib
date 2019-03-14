# rubocop:disable Naming/UncommunicativeMethodParamName
class Nib::Update
  def self.execute(_, _)
    exec('gem uninstall -ax nib && gem install nib')
  end
end
# rubocop:enable Naming/UncommunicativeMethodParamName
