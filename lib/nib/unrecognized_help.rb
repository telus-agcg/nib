# rubocop:disable Naming/UncommunicativeMethodParamName
class Nib::UnrecognizedHelp
  def self.execute(_, _)
    puts <<-MESSAGE.strip_heredoc

      Note:
        Unrecognized commands will be delegated to docker-compose.
        For example the following are equivalent:
          nib start
          docker-compose start
    MESSAGE
  end
end
# rubocop:enable Naming/UncommunicativeMethodParamName
