class Nib::Run
  include Nib::Command

  private

  def service_ports
    '--service-ports' if raw_options['service-ports']
  end

  def parsed_options
    [service_ports].compact
  end
end
