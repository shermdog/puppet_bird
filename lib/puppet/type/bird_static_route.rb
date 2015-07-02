Puppet::Type.newtype(:bird_static_route) do
  @doc = 'Manage static routes'

  ensurable

  IPV4_CIDR_REGEX = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$/

  newproperty(:enable) do
    desc 'Enable the interface, true or false'
    newvalues(:true, :false)
  end

  # Parameters (additional data)

  newparam(:prefix, namevar: true) do
    desc 'Route prefix, e.g. 192.168.74.0/24'

    validate do |value|
      fail("Prefix must be valid IPv4 CIDR Range") unless
          value =~ IPV4_CIDR_REGEX
    end
  end

  # Properties (state)

  newproperty(:description) do
    desc 'Interface physical port description'

    validate do |value|
      case value
      when String
        super(value)
        validate_features_per_value(value)
      else fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  newproperty(:mtu) do
    desc 'Interface Maximum Transmission Unit in bytes'
    munge { |v| Integer(v) }
    validate do |v|
      begin
        Integer(v) ? true : false
      rescue TypeError => err
        error "Cannot convert #{v.inspect} to an integer: #{err.message}"
      end
    end
  end

  newproperty(:speed) do
    desc 'Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]'
    newvalues(:auto, '1g', '10g', '40g', '56g', '100g', '100m', '10m')
  end

  newproperty(:duplex) do
    desc 'Duplex mode [auto*|full|half]'
    newvalues(:auto, :full, :half)
  end
end