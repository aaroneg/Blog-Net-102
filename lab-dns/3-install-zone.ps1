# Define the FQDN of your zone
$ZoneFQDN='lab.test'
$IPv4NetworkID='10.248.100.0/24'
$IPv6NetworkID='fdda:f6d4:f5a2:f1e6::/120'
$IPv4ReverseName='0.3.10.in-addr.arpa.dns'
$IPv6ReverseName='0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.e.1.f.2.a.5.f.4.d.6.f.a.d.d.f.ip6.arpa.dns'

# Add the zone main forward zone
Add-DnsServerPrimaryZone -Name $ZoneFQDN -ZoneFile "$ZoneFQDN.dns" -ComputerName $env:COMPUTERNAME
# Add the appropriate reverse zones
Add-DnsServerPrimaryZone -NetworkId $IPv4NetworkID -ZoneFile $IPv4ReverseName
Add-DnsServerPrimaryZone -NetworkId $IPv6NetworkID -ZoneFile $IPv6ReverseName