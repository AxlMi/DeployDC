# Define parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    [Parameter(Mandatory=$true)]
    [string]$AdminUsername,
    [Parameter(Mandatory=$true)]
    [string]$AdminPassword,
    [Parameter(Mandatory=$true)]
    [string]$DNSIPAddress
)
Write-Output "DomainName: $DomainName"
Write-Output "AdminUsername: $AdminUsername"
Write-Output "AdminPassword: $AdminPassword"
Write-Output "DNSIPAddress: $DNSIPAddress"

# Convert password to SecureString
$SecurePassword = ConvertTo-SecureString -String $AdminPassword -AsPlainText -Force

# Create a credential object
$Credential = New-Object System.Management.Automation.PSCredential ($AdminUsername, $SecurePassword)

# Change the DNS settings
Set-DNSClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSIPAddress

# Join the domain
Add-Computer -DomainName $DomainName -Credential $Credential -Restart -Force
