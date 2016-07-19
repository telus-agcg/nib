class Nib::UnrecognizedHelp
  def self.execute(_, _)
    puts <<~MESSAGE

      Note:
        Unrecognized commands will be delegated to docker-compose.
        For example the following are equivalent:
          nib start
          docker-compose start
    MESSAGE
  end
end
