$ZoneName='lab.test'
$DNSServer=$env:COMPUTERNAME

# Most of this will be repetitive, and some will simply be for exposition.
Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -A -Name 'gateway' -ipv4address '10.248.100.1' -CreatePtr -ComputerName $DNSServer
Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -A -Name 'lab-dns' -ipv4address '10.248.100.2' -CreatePtr -ComputerName $DNSServer
Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -A -Name 'lab-dhcp' -ipv4address '10.248.100.3' -CreatePtr -ComputerName $DNSServer

Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -AAAA -Name 'gateway' -ipv6address 'fdda:f6d4:f5a2:f1e6::1' -CreatePtr -ComputerName $DNSServer
Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -AAAA -Name 'lab-dns' -ipv6address 'fdda:f6d4:f5a2:f1e6::2' -CreatePtr -ComputerName $DNSServer
Add-DnsServerResourceRecord -ZoneName $ZoneName -Passthru -AAAA -Name 'lab-dhcp' -ipv6address 'fdda:f6d4:f5a2:f1e6::3' -CreatePtr -ComputerName $DNSServer