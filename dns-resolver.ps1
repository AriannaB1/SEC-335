param(
[Parameter(Mandatory=$true, Position=0)]
[string]$Network,

[Parameter(Mandatory=$true, Position=1)]
[string]$DnsServer
)

for ($i = 1; $i -le 254; $i++) {
$ip = "$Network.$i"
Resolve-DnsName -DnsOnly $ip -Server $DnsServer -ErrorAction Ignore
} 
