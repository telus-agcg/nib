module CoreExtensions
  module Hash
    def symbolize_keys!
      transform_keys(&:to_sym)
    end
  end
end

Hash.include CoreExtensions::Hash
