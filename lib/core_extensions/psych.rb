require 'yaml'

module CoreExtensions
  # Handle the fact that we are loading potentially "unsafe" YAML while still
  # supporting Ruby 2.7 and 3.0.
  module Psych
    def flexible_load(string)
      load_with = if ::Psych.respond_to?(:unsafe_load)
        :unsafe_load
      else
        :load
      end

      ::Psych.send(load_with, string)
    end

    def flexible_load_file(path)
      load_with = if ::Psych.respond_to?(:unsafe_load_file)
        :unsafe_load_file
      else
        :load_file
      end

      ::Psych.send(load_with, path)
    end
  end
end

Psych.extend CoreExtensions::Psych
