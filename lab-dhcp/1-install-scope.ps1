

# Server Scope Options
$Server4Values=@{
    DnsServer = '10.248.100.2'
    DnsDomain = 'lab.test'
}
Set-DhcpServerv4OptionValue @Server4Values

$Server6Values=@{
    DnsServer = 'fdda:f6d4:f5a2:f1e6::2'
    DomainSearchList = 'lab.test'
}
Set-DhcpServerv6OptionValue @Server6Values

# DHCP v4 has the concept of a start and end range inside a subnet. 
$V4ScopeID='10.248.100.0'
$IPv4Router='10.248.100.1'

$V4Scope=@{
    Name = 'Lab Subnet'
    StartRange = '10.248.100.50'
    EndRange = '10.248.100.99'
    SubnetMask = '255.255.255.0'
}
Add-DhcpServerv4Scope @V4Scope

Set-DhcpServerv4OptionValue -ScopeId $V4ScopeID -Router $IPv4Router

# DHCPv6 expects you to exclude any addresses you intend to use statically, instead of specifying the range.
#$V6ScopeID='10.248.100.0'
$V6Scope=@{
    Name = 'Lab V6 Subnet'
    Prefix = 'fdda:f6d4:f5a2:f1e6::'
}
Add-DhcpServerv6Scope @V6Scope

$V6ExclusionRange=@{
    StartRange = 'fdda:f6d4:f5a2:f1e6::1'
    EndRange = 'fdda:f6d4:f5a2:f1e6::31'
    Prefix = 'fdda:f6d4:f5a2:f1e6::'
}
Add-DhcpServerv6ExclusionRange @V6ExclusionRange

# We're not setting a router address - IPv6 includes an automatic address all routers listen on. Also router advertisements are a thing.