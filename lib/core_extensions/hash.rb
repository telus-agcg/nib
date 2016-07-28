module CoreExtensions
  module Hash
    def symbolize_keys!
      map { |k, v| [k.to_sym, v] }.to_h
    end
  end
end

Hash.include CoreExtensions::Hash
