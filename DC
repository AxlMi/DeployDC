# Define parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    [Parameter(Mandatory=$true)]
    [string]$NetbiosName
)

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
-Force:$true
