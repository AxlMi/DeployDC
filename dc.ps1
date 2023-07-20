# Define parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    [Parameter(Mandatory=$true)]
    [string]$NetbiosName,
    [Parameter(Mandatory=$true)]
    [string]$SafeModePassword
)

# Convert Safe Mode password to Secure String
$SafeModePasswordSecureString = ConvertTo-SecureString -String $SafeModePassword -AsPlainText -Force

# Import ServerManager
Import-Module ServerManager

# ADD ADDS && DNS
Add-WindowsFeature AD-Domain-Services,DNS

# Install DC
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "Win2012R2" `
-DomainName $DomainName `
-DomainNetbiosName $NetbiosName `
-ForestMode "Win2012R2" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $SafeModePasswordSecureString

# Add RSAT features
Add-WindowsFeature RSAT-ADDS

# Add RSAT-DNS-Server feature
Add-WindowsFeature RSAT-DNS-Server
