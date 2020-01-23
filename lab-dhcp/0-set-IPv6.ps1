# Change these to match the config in your documentation
$IPv6Address='fdda:f6d4:f5a2:f1e6::3'
$IPv6PrefixLength='64'
$IPv6Gateway='fdda:f6d4:f5a2:f1e6::1'
$IPv6DNSServer='fdda:f6d4:f5a2:f1e6::2'
$IPv4Gateway='10.248.100.1'
$IPv4DNSServer='10.248.100.2'
$FQDN='lab.test'

# Use our DNS server, then fall back to the gateway if the DNS server is offline
$DnsServerAddresses=($IPv4DNSServer,$IPv4Gateway,$IPv6DNSServer,$IPv6Gateway)

# Get the adapter 
$Adapter=(Get-NetAdapter)[0]
Set-DnsClient -InterfaceIndex $Adapter.ifIndex -ConnectionSpecificSuffix $FQDN
# turn off DHCP
Set-NetIPInterface -Dhcp Disabled -InterfaceIndex $Adapter.ifIndex
# configure DNS client
Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses $DnsServerAddresses

# Create the IPv6 config, create the address
$IPv6Arguments =@{
    InterfaceIndex = $Adapter.ifIndex
    PrefixLength = $IPv6PrefixLength
    IPAddress = $IPv6Address
    DefaultGateway = $IPv6Gateway
    AddressFamily = 'IPv6'
    Type = 'Unicast'
}
New-NetIPAddress @IPv6Arguments
