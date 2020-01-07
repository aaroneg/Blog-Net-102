# Change these to match the config in your documentation
$IPv6Address='fdda:f6d4:f5a2:f1e6::2'
$IPv6PrefixLength='120'
$IPv6Gateway='fdda:f6d4:f5a2:f1e6::1'
$IPv4Gateway='10.248.100.1'
$FQDN='lab.test'

# These bits will be gathered by powershell
# Get information about the only network adapter (or the first network adapter if you have more than one), save it in a variable.
$Adapter=(Get-NetAdapter)[0]
Set-DnsClient -InterfaceIndex $Adapter.ifIndex -ConnectionSpecificSuffix $FQDN
# Figure out what the already-set IPv4 address is of this machine.
$IPv4Address=(Get-NetIPAddress -ifIndex $Adapter.ifIndex -AddressFamily IPv4).IPAddress
# The DNS server should use itself first, then the default gateway:
$DnsServerAddresses=($IPv4Address,$IPv4Gateway,$IPv6Address,$IPv6Gateway)

# Set DHCP to disabled
Set-NetIPInterface -Dhcp Disabled -InterfaceIndex $Adapter.ifIndex
# Set our DNS client settings to the list we decided on earlier:
Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses $DnsServerAddresses
# We now build a hash with key = values and save it to a variable. This is called 'splatting'
$IPv6Arguments =@{
    InterfaceIndex = $Adapter.ifIndex
    PrefixLength = $IPv6PrefixLength
    IPAddress = $IPv6Address
    DefaultGateway = $IPv6Gateway
    AddressFamily = 'IPv6'
    Type = 'Unicast'
}
# Now we create the IP address using the hash table we created earlier. 
# Otherwise we would have to have one very long line that is hard to read through.
New-NetIPAddress @IPv6Arguments
