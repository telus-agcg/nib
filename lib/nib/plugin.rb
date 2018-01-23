class Nib::Plugin
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def basename
    @basename ||= File.basename(path, '_plugin.rb')
  end

  def name
    @name ||= basename.tr('_', '-')
  end

  def constant
    @constant ||= Object.const_get(name.split('-').map(&:capitalize).join('::'))
  end

  def applies?
    @applies ||= begin
      require path

      constant.applies?
    end
  end

  def binstub
    "#{path[0..-"/lib/#{basename}_plugin.rb".length]}bin/#{name}"
  end
end
