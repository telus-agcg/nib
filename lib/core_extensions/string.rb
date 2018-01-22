class String
  # Implementation from active_support https://git.io/vNVlN
  def strip_heredoc
    gsub(/^#{scan(/^[ \t]*(?=\S)/).min}/, ''.freeze)
  end
end
