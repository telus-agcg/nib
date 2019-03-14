class Nib::Plugins
  def self.execute(_, _)
    puts ''
    puts(
      (['Installed plugins:'] | potential_plugins.map(&:name))
      .join("\r\n  - ")
    )
  end

  def self.potential_plugins
    @potential_plugins ||= Gem
      .find_files('nib*_plugin.rb')
      .sort
      .map { |plugin_path| Nib::Plugin.new(plugin_path) }
  end

  def self.available_plugins
    @available_plugins ||= potential_plugins.select(&:applies?)
  end
end
