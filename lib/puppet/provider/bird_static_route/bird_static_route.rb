Puppet::Type.type(:bird_static_route).provide(:ruby) do
  commands :birdc => 'birdc'

  mk_resource_methods

  def self.instances
    routes = birdc('show route').split("\n")
    routes.shift

    routes.map do |line|
      line_values = line.split()
      #line_values.last.strip!
      #Puppet.debug line_values
      name = line_values.first
      Puppet.debug name
      new( :name => name,
           :ensure => :present)
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end